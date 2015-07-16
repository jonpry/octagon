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
		muxout : in dcmemout_type;
		dcin : in dctlin_type;
		dcout : out dctlout_type
	);
end dcontrol;

architecture Behavioral of dcontrol is

type cmd_type is (cmd_boot, cmd_wait, cmd_restart, cmd_tagcheck, cmd_tagwait, cmd_waitfordata, cmd_transfer_data, 
						cmd_update_tag, cmd_delay1, cmd_delay2, cmd_readtag, cmd_invtag, cmd_checkdirty, cmd_invwait, 
						cmd_checkdirty2, cmd_write, cmd_write_done, cmd_write_done2);

signal cmd_state : cmd_type := cmd_boot;
signal prevcmdstate : cmd_type := cmd_wait;

signal nextidx : unsigned(2 downto 0) := "000";

signal icfifo_rd : std_logic := '0';
signal icfifo_empty : std_logic;
signal icfifo_dout : std_logic_vector(IM_BITS-1 downto 6);
signal icfifo_tid : std_logic_vector(2 downto 0);
signal icfifo_asid : std_logic_vector(3 downto 0);
signal icfifo_miss : std_logic;
signal icfifo_mntn : std_logic;
signal icfifo_cacheop : cacheop_type;
signal icfifo_ll : std_logic;
signal icfifo_sv : std_logic;

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

begin

dcout.restarts <= restarts;

dc_fifo : entity work.dc_fifo port map(clk, icfifo_rd, muxout.do_op, muxout.tid, 
					muxout.asid, muxout.adr(IM_BITS-1 downto 6), muxout.dmiss, 
					muxout.dcache_op, muxout.cacheop, muxout.ll, icfifo_sv, icfifo_dout, icfifo_tid, 
					icfifo_asid, icfifo_miss, icfifo_mntn, icfifo_cacheop, icfifo_ll, icfifo_sv, icfifo_empty);

--State machine for completed requests
process(clk)
begin
	if clk='1' and clk'Event then
		icfifo_rd <= '0';
		dcout.mcb_rden <= '0';
		mcb_wren <= '0';
		dcout.clean <= '0';
		prevcmdstate <= cmd_state;
		
		--TODO: Cludge until MMU
		nc <= to_std_logic(icfifo_dout(IM_BITS-1) = '1');	
			
		if cmd_state = cmd_boot then	
			cmd_state <= cmd_wait;
		elsif cmd_state = cmd_wait then
			if icfifo_empty = '0' then
				if icfifo_mntn = '1' and icfifo_miss='1' then --nothing to do
					cmd_state <= cmd_restart;
				elsif dcin.mcb_cmd_full = '0' then
					if icfifo_mntn = '1' then --using physical location in cache so no tagcheck
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
			else
				--Line already
				cmd_state <= cmd_restart;				
			end if;
		elsif cmd_state = cmd_readtag then
			cmd_state <= cmd_invtag;
		elsif cmd_state = cmd_invtag then
			cmd_state <= cmd_invwait;
		elsif cmd_state = cmd_invwait then
			if icfifo_mntn = '1' and icfifo_cacheop = cacheop_inv then
				cmd_state <= cmd_restart;
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
		
		if cmd_state = cmd_tagwait then
			dcout.tagadr <= icfifo_asid & icfifo_dout;
			dcout.sv <= icfifo_sv;
		end if;
	
		dcout.tag_wr <= '0';
		if cmd_state = cmd_readtag then
			dcout.tagadr <= (IM_BITS-1+4 downto 10 => '1') & icfifo_dout(9 downto 6);
			if icfifo_mntn = '1' then
				dcout.tagidx <= icfifo_dout(12 downto 10);
			else
				dcout.tagidx <= std_logic_vector(nextidx);
			end if;
		end if;
		
		if cmd_state = cmd_invtag then
			if icfifo_mntn = '0' or icfifo_cacheop /= cacheop_clean then
				dcout.tag_wr <= '1';
			end if;
			dcout.clean <= '1';
		end if;
		
		if cmd_state = cmd_checkdirty then
			oldtag <= dcin.tag;
		end if;
		
		--TODO: probably need one more wait cycle here
		if icfifo_mntn = '1' then
			dirtyidx <= unsigned(icfifo_dout(12 downto 11));
		else
			dirtyidx <= nextidx(2 downto 1);
		end if;
		
		dirty <= to_std_logic(muxout.dirty(to_integer(dirtyidx)) = '1' and nc = '0');
		
		if cmd_state = cmd_update_tag or cmd_state = cmd_tagcheck then
			dcout.tagadr <= icfifo_asid & icfifo_dout;
			if icfifo_mntn = '1' then
				dcout.tagidx <= icfifo_dout(12 downto 10);
			else
				dcout.tagidx <= std_logic_vector(nextidx);
			end if;
		end if;

		if cmd_state = cmd_update_tag then
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
	end if;
end process;

--Send request
process(clk)
begin
	if clk='1' and clk'Event then
		dcout.mcb_en <= '0';
		mcb_req_done <= '0';
		cmd_mcb_req_done <= '0';
		dcout.mcb_bl <= "001111";      --64 bytes = 16 words - 1

		if cmd_state = cmd_readtag and icfifo_mntn='0' and nc='0' and mcb_req_done = '0' then
		--Send request to MCB
			dcout.mcb_adr <= icfifo_dout(IM_BITS-3 downto 6) & (5 downto 0 => '0');
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
end process;


end Behavioral;

