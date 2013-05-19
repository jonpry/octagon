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

type ictl_type is (ictl_wfr, ictl_tagcheck, ictl_noreq, ictl_req, ictl_delay, ictl_delay2,
						 ictl_wait_for_req);
type cmd_type is (cmd_wait, cmd_restart, cmd_waitfordata, cmd_transfer_data, cmd_update_tag,
						cmd_delay1, cmd_delay2, cmd_invtag, cmd_checkdirty, cmd_invwait, cmd_checkdirty2,
						cmd_write, cmd_write_done, cmd_write_done2);

signal cmd_state : cmd_type := cmd_wait;
signal state : ictl_type := ictl_wfr;
signal prevcmdstate : cmd_type := cmd_wait;

signal nextidx : unsigned(2 downto 0) := "000";

signal icfifo_rd : std_logic := '0';
signal icfifo_empty : std_logic;
signal icfifo_dout : std_logic_vector(IM_BITS-1 downto 6);
signal icfifo_tid : std_logic_vector(2 downto 0);

signal wcount : unsigned(3 downto 0);
signal rcount : unsigned(3 downto 0);

signal ilookahead_cmp : std_logic_vector(7 downto 0);
signal ilookahead_wr : std_logic;

signal dnr : std_logic;
signal cmddnr : std_logic;
signal cmd_wr : std_logic;
signal cmd_rd : std_logic;
signal cmd_empty : std_logic;
signal cmd_tid : std_logic_vector(2 downto 0);
signal cmd_dout : std_logic_vector(IM_BITS-1 downto 6);

signal rden_delay : std_logic;
signal dirty : std_logic;

signal restarts : std_logic_vector(7 downto 0) := X"00";

signal mcb_req_done : std_logic;
signal cmd_mcb_req_done : std_logic;

begin

dcout.restarts <= restarts;

dcmd_fifo : entity work.dcmd_fifo port map(clk, cmd_rd, cmd_wr, icfifo_tid, 
					dnr, icfifo_dout, cmd_dout, cmd_tid, 
					cmddnr, cmd_empty);
dc_fifo : entity work.dc_fifo port map(clk, icfifo_rd, muxout.dmiss, muxout.tid, 
					muxout.adr(IM_BITS-1 downto 6), icfifo_dout, icfifo_tid, icfifo_empty);
ilookahead : entity work.ilookahead port map(clk, ilookahead_wr, icfifo_dout, ilookahead_cmp);


--Primary state machine
process(clk)
begin
	if clk='1' and clk'Event then
		icfifo_rd <= '0';
		ilookahead_wr <= '0';
		cmd_wr <= '0';
		
		if state = ictl_wfr then
			if icfifo_empty = '0' and dcin.mcb_cmd_full = '0' then
				state <= ictl_tagcheck;
			end if;
		elsif state = ictl_tagcheck then	
			if ilookahead_cmp /= X"00" then
				state <= ictl_noreq;
			else
				state <= ictl_req;
			end if;
		elsif state = ictl_req then
				if mcb_req_done = '1' then
					state <= ictl_wait_for_req;
				end if;
		elsif state = ictl_wait_for_req then
				ilookahead_wr <= '1';
				dnr <= '0';
				icfifo_rd <= '1';
				cmd_wr <= '1';
				state <= ictl_delay;
		elsif state = ictl_noreq then
				dnr <= '1';
				state <= ictl_delay;
				icfifo_rd <= '1';
				cmd_wr <= '1';
		elsif state = ictl_delay then
				state <= ictl_delay2;
		elsif state = ictl_delay2 then
				state <= ictl_wfr;
		end if;
	end if;
end process;

--State machine for completed requests
process(clk)
begin
	if clk='1' and clk'Event then
		cmd_rd <= '0';
		dcout.mcb_rden <= '0';
		prevcmdstate <= cmd_state;
	
		if cmd_state = cmd_wait then
			if cmd_empty = '0' then
				if cmddnr = '1' then
					cmd_state <= cmd_restart;
				else
					cmd_state <= cmd_invtag;
				end if;
			end if;
		elsif cmd_state = cmd_invtag then
			cmd_state <= cmd_invwait;
		elsif cmd_state = cmd_invwait then
			cmd_state <= cmd_checkdirty;
		elsif cmd_state = cmd_checkdirty then
			cmd_state <= cmd_checkdirty2;
		elsif cmd_state = cmd_checkdirty2 then
			if dirty = '1' then
				cmd_state <= cmd_write;
			else
				cmd_state <= cmd_waitfordata;
			end if;
		elsif cmd_state = cmd_write then
			if wcount /= "0000" then
				dcout.mcb_wren <= '1';
			end if;
			if wcount = "1111" then
				cmd_state <= cmd_write_done; 
			end if;
		elsif cmd_state = cmd_write_done then
			dcout.mcb_wren <= '1';
			cmd_state <= cmd_write_done2;
		elsif cmd_state = cmd_write_done2 then
			if cmd_mcb_req_done = '1' then
				cmd_state <= cmd_waitfordata;
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
			cmd_rd <= '1';
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
			dcout.tagadr <= (IM_BITS-1 downto 10 => '1') & cmd_dout(9 downto 6);
			dcout.tagidx <= std_logic_vector(nextidx);
			dcout.tag_wr <= '1';
		end if;
		
		if cmd_state = cmd_checkdirty then
			dirty <= dcin.dirty(to_integer(nextidx(2 downto 1)));
		end if;
		
		if cmd_state = cmd_update_tag then
			dcout.tagadr <= cmd_dout;
			dcout.tagidx <= std_logic_vector(nextidx);
			dcout.tag_wr <= '1';
			nextidx <= nextidx + 1;	
		end if;
		
		if cmd_state = cmd_waitfordata then
			rden_delay <= '1';
		end if;
	
		dcout.memwe <= '0';
		dcout.memadr <= cmd_dout(9 downto 6) & std_logic_vector(wcount) & "00";
		if cmd_state = cmd_transfer_data then
			--this may not be fast enough. must generate this signal async
			if wcount = "1111" and dcin.mcb_empty = '0' then
				dcout.mcb_rden <= '0';
			else
				dcout.mcb_rden <= '1';
			end if;
			
			if dcin.mcb_empty = '0' then
				dcout.data <= dcin.mcb_data;
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
		
		dcout.mcb_data <= dcin.dout(to_integer(unsigned(nextidx(2 downto 1))));
	end if;
end process;

--Restart
process(clk)
begin
	if clk='1' and clk'Event then
		restarts <= restarts and not dcin.restarted;
		if cmd_state = cmd_restart then
			restarts(to_integer(unsigned(cmd_tid))) <= '1';
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

		if state = ictl_req and mcb_req_done = '0' then
		--Send request to MCB
			dcout.mcb_adr <= "0000" & icfifo_dout & (5 downto 0 => '0');
			dcout.mcb_cmd <= "001";
			dcout.mcb_en <= '1';
			mcb_req_done <= '1'; 
		elsif cmd_state = cmd_write_done2 and cmd_mcb_req_done = '0' then
			dcout.mcb_cmd <= "000";
			dcout.mcb_en <= '1';
			cmd_mcb_req_done <= '1';
			dcout.mcb_adr <= "0000" & cmd_dout & (5 downto 0 => '0');
		end if;
	end if;
end process;


end Behavioral;
