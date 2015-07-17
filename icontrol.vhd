----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:58:36 04/29/2013 
-- Design Name: 
-- Module Name:    icontrol - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.octagon_types.all;
use work.octagon_funcs.all;

entity icontrol is
	Port ( 
		clk : in  std_logic;
		muxout : in icmuxout_type;
		iin : in ictlin_type;
		iout : out ictlout_type
	);
end icontrol;

architecture Behavioral of icontrol is

type cmd_type is (cmd_boot, cmd_wait, cmd_tagwait, cmd_tagcheck, cmd_restart, 
						cmd_transfer_data, cmd_update_tag, cmd_delay1, cmd_delay2,
						cmd_tlb_miss, cmd_wait_data);

signal cmd_state : cmd_type := cmd_boot;
signal prevcmdstate : cmd_type := cmd_wait;

signal nextidx : unsigned(2 downto 0) := "000";

signal icfifo_rd : std_logic := '0';
signal icfifo_wr : std_logic := '0';
signal icfifo_empty : std_logic;
signal icfifo_dout : std_logic_vector(IM_BITS-1+4 downto 6); --ASID
signal icfifo_tid : std_logic_vector(2 downto 0);
signal icfifo_sv : std_logic;
signal icfifo_tlb : std_logic;

signal tlb_asid : std_logic_vector(3 downto 0);
signal tlb_perm : std_logic_vector(2 downto 0);
signal tlb_phys : std_logic_vector(IM_BITS-1 downto 12);
signal tlb_hit : std_logic;
signal tlb_empty : std_logic;

signal wcount : unsigned(3 downto 0);

signal dnr : std_logic;

signal rden_delay : std_logic;

signal restarts : std_logic_vector(7 downto 0) := X"00";
signal memwe : std_logic;
signal data : std_logic_vector(31 downto 0);
signal memadr : std_logic_vector(9 downto 0);

signal phys_sel : std_logic_vector(2 downto 0);

begin

iout.restarts <= restarts;
icfifo_wr <= to_std_logic(muxout.imiss='1' and iin.mcb_cmd_full = '0' and muxout.ibuf_match = '0');
iout.ireqtlb <= icfifo_wr;

ic_fifo : entity work.ic_fifo port map(clk, icfifo_rd, icfifo_wr, muxout.tlb, muxout.tid, muxout.asid, muxout.sv,
					muxout.pc(IM_BITS-1 downto 6), icfifo_tlb, icfifo_dout, icfifo_tid, icfifo_sv, icfifo_empty);
					
ic_tlbfifo : entity work.ic_tlbfifo port map(clk, icfifo_rd, iin.tlback, iin.tlbasid, iin.tlbperm, iin.tlbphys, 
					iin.tlbhit, tlb_asid, tlb_perm, tlb_phys, tlb_hit, tlb_empty);


phys_sel(0) <= to_std_logic(iin.ownsp(1)='1' or iin.ownsp(3)='1' or iin.ownsp(5)='1' or iin.ownsp(7)='1');
phys_sel(1) <= to_std_logic(iin.ownsp(2)='1' or iin.ownsp(3)='1' or iin.ownsp(6)='1' or iin.ownsp(7)='1');
phys_sel(2) <= to_std_logic(iin.ownsp(4)='1' or iin.ownsp(5)='1' or iin.ownsp(6)='1' or iin.ownsp(7)='1');

--State machine for completed requests
process(clk)
begin
	if clk='1' and clk'Event then
		icfifo_rd <= '0';
		iout.mcb_rden <= '0';
		prevcmdstate <= cmd_state;
		iout.tagphys <= tlb_phys & icfifo_dout(11 downto 10);
		if icfifo_tlb = '0' then
			iout.tagphys  <= icfifo_dout(IM_BITS-1 downto 10);
		end if;
		iout.tagadr <= icfifo_dout(IM_BITS-1+4 downto 6);
		iout.tagidx <= std_logic_vector(nextidx);
		iout.sv <= icfifo_sv;
			
		if cmd_state = cmd_boot then
			cmd_state <= cmd_wait;
		elsif cmd_state = cmd_wait then
			if icfifo_empty = '0' and tlb_empty = '0' then
				cmd_state <= cmd_tagwait;
			end if;
		elsif cmd_state = cmd_tagwait then
			cmd_state <= cmd_tagcheck;
		elsif cmd_state = cmd_tagcheck then
			--TODO: this could easily be a source of timing problem
			if iin.ownst /= "00000000" then
				cmd_state <= cmd_restart;
			else
				cmd_state <= cmd_wait_data;
				if icfifo_tlb = '1' then
					if tlb_hit = '1' and iin.ownsp /= X"00" then --Synonym detected
						nextidx <= unsigned(phys_sel);
						cmd_state <= cmd_update_tag;
					end if;
					if tlb_hit = '0' or (tlb_hit = '1' and tlb_perm(0) = '0') then --TLB miss, uh ohs
						cmd_state <= cmd_tlb_miss;
					end if;
				end if;
			end if;
		elsif cmd_state = cmd_tlb_miss then
			--TODO: implement me
		elsif cmd_state = cmd_wait_data then
			if iin.mcb_empty = '0' then
				cmd_state <= cmd_transfer_data;
			end if;
		elsif cmd_state = cmd_transfer_data then
			if wcount = "1111" and iin.mcb_empty = '0' then
				cmd_state <= cmd_update_tag;
			end if;
		elsif cmd_state = cmd_update_tag then
			cmd_state <= cmd_restart;  
		elsif cmd_state = cmd_restart then
			icfifo_rd <= '1';
			cmd_state <= cmd_delay1;
		elsif cmd_state = cmd_delay1 then
			cmd_state <= cmd_delay2;
		elsif cmd_state = cmd_delay2 then
			cmd_state <= cmd_wait;
		end if;
		
		if cmd_state = cmd_wait then
			wcount <= (others => '0');
		end if;
	
		iout.tag_wr <= '0';
		if cmd_state = cmd_transfer_data and prevcmdstate = cmd_wait_data then
			iout.tagadr <= (IM_BITS-1+4 downto 10 => '1') & icfifo_dout(9 downto 6);
			iout.tag_wr <= '1';
		end if;
		
		if cmd_state = cmd_update_tag then
			--This little gem ensures "1000" gets loaded as ASID even if SR says something else
			if icfifo_tlb='1' then
				iout.tagadr(IM_BITS-1+4 downto IM_BITS) <= tlb_asid;
			end if;
			iout.tag_wr <= '1';
			nextidx <= nextidx + 1;	
		end if;
		
		if cmd_state = cmd_tagcheck then
			rden_delay <= '1';
		end if;
	
		memwe <= '0';
		memadr <= icfifo_dout(9 downto 6) & std_logic_vector(wcount) & "00";
		if cmd_state = cmd_transfer_data then
			--this may not be fast enough. must generate this signal async
			if wcount = "1111" and iin.mcb_empty = '0' then
				iout.mcb_rden <= '0';
			else
				iout.mcb_rden <= '1';
			end if;
			if iin.mcb_empty = '0' then
				data <= iin.mcb_data;
				memwe <= '1';
				if rden_delay = '1' then
					rden_delay <= '0';
				else
					wcount <= wcount + 1;
				end if;
			end if;
		end if;
		
		iout.memadr <= memadr;
		iout.memwe <= memwe;
		iout.data <= data;
	end if;
end process;

--Restart
process(clk)
begin
	if clk='1' and clk'Event then
		restarts <= restarts and not iin.restarted;
		if cmd_state = cmd_restart then
			restarts(to_integer(unsigned(icfifo_tid))) <= '1';
		end if;
		if muxout.imiss='1' and iin.mcb_cmd_full = '1' then
			restarts(to_integer(unsigned(muxout.tid))) <= '1';
		end if;
	end if;
end process;

--Send request
process(clk)
begin
	if clk='1' and clk'Event then
		iout.mcb_en <= '0';
		iout.mcb_cmd <= "001";
		iout.mcb_bl <= "001111";      --64 bytes = 16 words - 1

		if cmd_state = cmd_wait_data and prevcmdstate = cmd_tagcheck then
		--Send request to MCB
			iout.mcb_adr <= icfifo_dout(IM_BITS-3 downto 6) & (5 downto 0 => '0');
			if icfifo_tlb = '1' then
				iout.mcb_adr(IM_BITS-3 downto 12) <= tlb_phys(IM_BITS-3 downto 12);
			end if;
			iout.mcb_en <= '1';
		end if;
	end if;
end process;


end Behavioral;

