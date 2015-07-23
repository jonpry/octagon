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

entity dcontrol is
	Port ( 
		clk : in  std_logic;
		reset_n : in std_logic;
		muxout : in dcmemout_type;
		dcin : in dctlin_type;
		dcout : out dctlout_type
	);
end dcontrol;

architecture Behavioral of dcontrol is

type cmd_type is (cmd_boot, cmd_wait, cmd_restart, cmd_tagcheck, cmd_tagwait, cmd_waitfordata, cmd_transfer_data, 
						cmd_update_tag, cmd_delay1, cmd_delay2, cmd_readtag, cmd_invtag, cmd_checkdirty, cmd_invwait, 
						cmd_checkdirty2, cmd_write, cmd_write_done, cmd_write_done2, cmd_tlb_miss);

signal cmd_state : cmd_type := cmd_boot;
signal prevcmdstate : cmd_type := cmd_wait;

signal nextidx : unsigned(2 downto 0) := "000";

signal icfifo_rd : std_logic := '0';
signal icfifo_wr : std_logic;
signal icfifo_empty : std_logic;
signal icfifo_dout : std_logic_vector(IM_BITS-1 downto 6);
signal icfifo_tid : std_logic_vector(2 downto 0);
signal icfifo_asid : std_logic_vector(3 downto 0);
signal icfifo_miss : std_logic;
signal icfifo_mntn : std_logic;
signal icfifo_cacheop : cacheop_type;
signal icfifo_ll : std_logic;
signal icfifo_sv : std_logic;
signal icfifo_tlb : std_logic;

signal tlb_asid : std_logic_vector(3 downto 0);
signal tlb_perm : std_logic_vector(2 downto 0);
signal tlb_phys : std_logic_vector(IM_BITS-1 downto 12);
signal tlb_hit : std_logic;
signal tlb_empty : std_logic;

signal nc : std_logic;

signal wcount : unsigned(3 downto 0);
signal rcount : unsigned(3 downto 0);

signal rden_delay : std_logic;
signal dirty : std_logic;

signal restarts : std_logic_vector(7 downto 0) := X"00";

signal mcb_req_done : std_logic;
signal cmd_mcb_req_done : std_logic;

signal oldtag : std_logic_vector(DM_BITS-1+4 downto 10);

signal mcb_wren : std_logic;

signal dirtyidx : unsigned(1 downto 0);
signal phys_sel : std_logic_vector(2 downto 0);

begin

dcout.restarts <= restarts;

icfifo_wr <= to_std_logic(muxout.do_op = '1' and dcin.ireqtlb = '0');
dcout.dreqtlb <= icfifo_wr;

dc_fifo : entity work.dc_fifo port map(clk, reset_n, icfifo_rd, icfifo_wr, muxout.tid, 
					muxout.asid, muxout.adr(IM_BITS-1 downto 6), muxout.dmiss, 
					muxout.dcache_op, muxout.cacheop, muxout.ll, muxout.sv, muxout.tlb, icfifo_dout, icfifo_tid, 
					icfifo_asid, icfifo_miss, icfifo_mntn, icfifo_cacheop, icfifo_ll, icfifo_sv, icfifo_tlb, icfifo_empty);
					
dc_tlbfifo : entity work.ic_tlbfifo port map(clk, reset_n, icfifo_rd, dcin.tlback, dcin.tlbasid, dcin.tlbperm, dcin.tlbphys, 
					dcin.tlbhit, tlb_asid, tlb_perm, tlb_phys, tlb_hit, tlb_empty);
					
phys_sel(0) <= to_std_logic(dcin.ownsp(1)='1' or dcin.ownsp(3)='1' or dcin.ownsp(5)='1' or dcin.ownsp(7)='1');
phys_sel(1) <= to_std_logic(dcin.ownsp(2)='1' or dcin.ownsp(3)='1' or dcin.ownsp(6)='1' or dcin.ownsp(7)='1');
phys_sel(2) <= to_std_logic(dcin.ownsp(4)='1' or dcin.ownsp(5)='1' or dcin.ownsp(6)='1' or dcin.ownsp(7)='1');

					
--State machine for completed requests
process(clk,reset_n)
begin
	if clk='1' and clk'Event then
		icfifo_rd <= '0';
		dcout.mcb_rden <= '0';
		mcb_wren <= '0';
		dcout.clean <= '0';
		prevcmdstate <= cmd_state;

		dcout.sv <= icfifo_sv;
		dcout.tagphys <= tlb_phys & icfifo_dout(11 downto 10);
		if icfifo_tlb = '0' then
			dcout.tagphys <= icfifo_dout(IM_BITS-1 downto 10);
		end if;
		dcout.tagadr <= icfifo_asid & icfifo_dout(IM_BITS-1 downto 6);

		
		--Calculate non-cached bit
		nc <= to_std_logic(icfifo_dout(IM_BITS-1) = '1');	
		if icfifo_tlb = '1' then
			nc <= to_std_logic(tlb_phys(IM_BITS-1) = '1');			
		end if;
		
		if cmd_state = cmd_boot then	
			cmd_state <= cmd_wait;
		elsif cmd_state = cmd_wait then
			if icfifo_empty = '0' and tlb_empty = '0' then
				if icfifo_mntn = '1' and icfifo_miss='1' then --nothing to do
					cmd_state <= cmd_restart;
				elsif dcin.mcb_cmd_full = '0' then
					if icfifo_mntn = '1' then --using physical location in cache so no tagcheck 
														--or tlb lookup
						cmd_state <= cmd_readtag;
					else
						cmd_state <= cmd_tagwait;
					end if;
				end if;
			end if;
		elsif cmd_state = cmd_tagwait then
			cmd_state <= cmd_tagcheck;
		elsif cmd_state = cmd_tagcheck then
			if dcin.ownst = "00000000" then
				--fetch and allocate
				cmd_state <= cmd_readtag;
				if icfifo_tlb = '1' then
					if tlb_hit = '1' and dcin.ownsp /= X"00" then --Synonym detected
						nextidx <= unsigned(phys_sel);
						cmd_state <= cmd_update_tag;
					end if;
					if tlb_hit = '0' or (tlb_hit = '1' and tlb_perm(2 downto 1) = "00") then --TLB miss, uh ohs
						cmd_state <= cmd_tlb_miss;
					end if;
				end if;				
			else
				--Line already
				cmd_state <= cmd_restart;				
			end if;
		elsif cmd_state = cmd_tlb_miss then
			--TODO: throw exception!!!!
		elsif cmd_state = cmd_readtag then
			cmd_state <= cmd_invtag;
		elsif cmd_state = cmd_invtag then
			cmd_state <= cmd_invwait;
		elsif cmd_state = cmd_invwait then
			if icfifo_mntn = '1' and icfifo_cacheop = cacheop_inv then
				cmd_state <= cmd_restart;
				dcout.clean <= '1'; --Don't allow dirty lines that are invalid
			else
				cmd_state <= cmd_checkdirty;
			end if;
		elsif cmd_state = cmd_checkdirty then
			cmd_state <= cmd_checkdirty2;
		elsif cmd_state = cmd_checkdirty2 then
			if dirty = '1' and oldtag(IM_BITS-1) = '0' then
				cmd_state <= cmd_write;
			else
				if icfifo_mntn = '1' then
					cmd_state <= cmd_restart;
				else
					if nc = '1' then
						cmd_state <= cmd_update_tag;
					else
						cmd_state <= cmd_waitfordata;
					end if;
				end if;
			end if;
		elsif cmd_state = cmd_write then
			if wcount /= "0000" then
				mcb_wren <= '1';
			end if;
			if wcount = "1111" then
				cmd_state <= cmd_write_done; 
			end if;
		elsif cmd_state = cmd_write_done then
			mcb_wren <= '1';
			cmd_state <= cmd_write_done2;
		elsif cmd_state = cmd_write_done2 then
			if cmd_mcb_req_done = '1' then
				if icfifo_mntn = '1' then
					cmd_state <= cmd_restart;
				else
					if nc = '1' then
						cmd_state <= cmd_update_tag;
					else
						cmd_state <= cmd_waitfordata;
					end if;
				end if;
			end if;
		elsif cmd_state = cmd_waitfordata then
			if dcin.mcb_empty = '0' then
				cmd_state <= cmd_transfer_data;
			end if;
		elsif cmd_state = cmd_transfer_data then
			if wcount = "1111" and dcin.mcb_empty = '0' then
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
			rcount <= (others => '0');
		end if;
			
		dcout.tag_wr <= '0';
		
		if cmd_state = cmd_invtag then
			dcout.tagadr <= (IM_BITS-1+4 downto 10 => '1') & icfifo_dout(9 downto 6);
			dcout.tag_wr <= '1';
			oldtag <= dcin.tag;
		end if;
		
		if cmd_state = cmd_checkdirty2 then
			dcout.clean <= dirty;
		end if;
			
		--TODO: probably need one more wait cycle here
		if icfifo_mntn = '1' then
			dirtyidx <= unsigned(icfifo_dout(12 downto 11));
		else
			dirtyidx <= nextidx(2 downto 1);
		end if;
		
		dirty <= to_std_logic(muxout.dirty(to_integer(dirtyidx)) = '1' and nc = '0');
		
--		if cmd_state = cmd_update_tag or cmd_state = cmd_tagcheck or cmd_state = cmd_invtag then
			if icfifo_mntn = '1' then
				dcout.tagidx <= icfifo_dout(12 downto 10);
			else
				dcout.tagidx <= std_logic_vector(nextidx);
			end if;
--		end if;

		if cmd_state = cmd_update_tag then
			--This little gem ensures "1000" gets loaded as ASID even if SR says something else
			if icfifo_tlb='1' then
				dcout.tagadr(IM_BITS-1+4 downto IM_BITS) <= tlb_asid;
			end if;
			dcout.tag_wr <= '1';
			nextidx <= nextidx + 1;	
		end if;
		
		if cmd_state = cmd_waitfordata then
			rden_delay <= '1';
		end if;
	
		dcout.memwe <= '0';
		dcout.memadr <= icfifo_dout(9 downto 6) & std_logic_vector(wcount) & "00";
		if cmd_state = cmd_transfer_data then
			--this may not be fast enough. must generate this signal async
			if wcount = "1111" and dcin.mcb_empty = '0' then
				dcout.mcb_rden <= '0';
			else
				dcout.mcb_rden <= '1';
			end if;
			
			if dcin.mcb_empty = '0' then
				dcout.memwe <= '1';
			end if;
		end if;
	
		if cmd_state = cmd_transfer_data or cmd_state = cmd_write then
			if dcin.mcb_empty = '0' or cmd_state = cmd_write then
				if rden_delay = '1' then
					rden_delay <= '0';
				else
					wcount <= wcount + 1;
				end if;
			end if;
		end if;
		
		dcout.data <= dcin.mcb_data;
		dcout.mcb_data <= muxout.ctl_data(to_integer(dirtyidx));
		dcout.mcb_wren <= mcb_wren;
	end if;
	if reset_n='0' then
		icfifo_rd <= '0';
		dcout.mcb_rden <= '0';
		mcb_wren <= '0';
		dcout.clean <= '0';
		dcout.memwe <= '0';
		dcout.tag_wr <= '0';
		cmd_state <= cmd_boot;
		wcount <= (others => '0');
	end if;
end process;


--Restart
process(clk)
begin
	if clk='1' and clk'Event then
		dcout.mntn_restart <= '0';
		restarts <= restarts and not dcin.restarted;
		dcout.mntn_tid <= icfifo_tid;
		if cmd_state = cmd_restart then
			restarts(to_integer(unsigned(icfifo_tid))) <= '1';
			dcout.mntn_restart <= icfifo_mntn;
		end if;
		if muxout.do_op = '1' and dcin.ireqtlb = '1' then
			restarts(to_integer(unsigned(muxout.tid))) <= '1';		
		end if;
	end if;
end process;

--Send request
process(clk,reset_n)
begin
	if clk='1' and clk'Event then
		dcout.mcb_en <= '0';
		mcb_req_done <= '0';
		cmd_mcb_req_done <= '0';
		dcout.mcb_bl <= "001111";      --64 bytes = 16 words - 1

		if cmd_state = cmd_readtag and icfifo_mntn='0' and nc='0' and mcb_req_done = '0' then
		--Send request to MCB
			dcout.mcb_adr <= icfifo_dout(IM_BITS-3 downto 6) & (5 downto 0 => '0');
			if icfifo_tlb = '1' then
				dcout.mcb_adr(IM_BITS-3 downto 12) <= tlb_phys(IM_BITS-3 downto 12);
			end if;
			dcout.mcb_cmd <= "001";
			dcout.mcb_en <= '1';
			mcb_req_done <= '1'; 
		--TODO: this involves checking the phys of old tag
		elsif cmd_state = cmd_write_done2 and cmd_mcb_req_done = '0' and oldtag(IM_BITS-1) = '0' then
			dcout.mcb_cmd <= "000";
			dcout.mcb_en <= '1';
			cmd_mcb_req_done <= '1';
			dcout.mcb_adr <= oldtag(IM_BITS-3 downto 10) & icfifo_dout(9 downto 6) & (5 downto 0 => '0');
		end if;
	end if;
	if reset_n = '0' then
		dcout.mcb_en <= '0';
	end if;
end process;


end Behavioral;

