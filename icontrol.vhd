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
		decout : in decout_type;
		imemout : in icfetchout_type;
		iin : in ictlin_type;
		iout : out ictlout_type
	);
end icontrol;

architecture Behavioral of icontrol is

type ictl_type is (ictl_wfr, ictl_tagcheck, ictl_noreq, ictl_req);
type cmd_type is (cmd_wait, cmd_restart, cmd_waitfordata, cmd_transfer_data, cmd_update_tag);

signal cmd_state : cmd_type := cmd_wait;
signal state : ictl_type := ictl_wfr;
signal prevcmdstate : cmd_type := cmd_wait;

signal nextidx : unsigned(2 downto 0);

signal icfifo_rd : std_logic := '0';
signal icfifo_empty : std_logic;
signal icfifo_dout : std_logic_vector(IM_BITS-1 downto 6);
signal icfifo_tid : std_logic_vector(2 downto 0);

signal wcount : unsigned(3 downto 0);

signal ilookahead_cmp : std_logic_vector(7 downto 0);
signal ilookahead_wr : std_logic;

signal dnr : std_logic;
signal cmddnr : std_logic;
signal cmd_wr : std_logic;
signal cmd_rd : std_logic;
signal cmd_empty : std_logic;
signal cmd_tid : std_logic_vector(2 downto 0);
signal cmd_dout : std_logic_vector(IM_BITS-1 downto 6);

signal restarts : std_logic_vector(7 downto 0) := X"00";

begin

iout.restarts <= restarts;

icmd_fifo : entity work.icmd_fifo port map(clk, cmd_rd, cmd_wr, icfifo_tid, 
					dnr, icfifo_dout, cmd_dout, cmd_tid, cmddnr, cmd_empty);
ic_fifo : entity work.ic_fifo port map(clk, icfifo_rd, decout.imiss, decout.tid, 
					decout.pc(IM_BITS-1 downto 6), icfifo_dout, icfifo_tid, icfifo_empty);
ilookahead : entity work.ilookahead port map(clk, ilookahead_wr, icfifo_dout, ilookahead_cmp);


--Primary state machine
process(clk)
begin
	if clk='1' and clk'Event then
		icfifo_rd <= '0';
		ilookahead_wr <= '0';
		
		if state = ictl_wfr then
			if icfifo_empty = '0' and iin.mcb_cmd_full = '0' then
				state <= ictl_tagcheck;
			end if;
		elsif state = ictl_tagcheck then	
			if ilookahead_cmp /= X"00" then
				state <= ictl_noreq;
			else
				state <= ictl_req;
			end if;
		elsif state = ictl_req then
				ilookahead_wr <= '1';
				dnr <= '0';
				icfifo_rd <= '1';
				cmd_wr <= '1';
				state <= ictl_wfr;		
		elsif state = ictl_noreq then
				dnr <= '1';
				state <= ictl_wfr;
				icfifo_rd <= '1';
				cmd_wr <= '1';
		end if;
	end if;
end process;

--State machine for completed requests
process(clk)
begin
	if clk='1' and clk'Event then
		cmd_rd <= '0';
		iout.mcb_rden <= '0';
		prevcmdstate <= cmd_state;
	
		if cmd_state = cmd_wait then
			if cmd_empty = '0' then
				if cmddnr = '1' then
					cmd_state <= cmd_restart;
				else
					cmd_state <= cmd_waitfordata;
				end if;
			end if;
		elsif cmd_state = cmd_waitfordata then
			if iin.mcb_empty = '0' then
				iout.mcb_rden <= '1';
				cmd_state <= cmd_transfer_data;
			end if;
		elsif cmd_state = cmd_transfer_data then
			if wcount = "1111" then
				cmd_state <= cmd_update_tag;
			else
				iout.mcb_rden <= '1';
			end if;
		elsif cmd_state = cmd_update_tag then
			cmd_state <= cmd_restart;
		elsif cmd_state = cmd_restart then
			cmd_rd <= '1';
		end if;
	
		iout.tag_wr <= '0';
		if cmd_state = cmd_transfer_data and prevcmdstate = cmd_waitfordata then
			iout.tagadr <= (others => '1');
			iout.tagidx <= std_logic_vector(nextidx);
			iout.tag_wr <= '1';
			wcount <= (others => '0');
		end if;
		
		if cmd_state = cmd_update_tag then
			iout.tagadr <= cmd_dout;
			iout.tagidx <= std_logic_vector(nextidx);
			iout.tag_wr <= '1';
			nextidx <= nextidx + 1;	
		end if;
	
		iout.memadr <= cmd_dout(9 downto 6) & std_logic_vector(wcount) & "00";
		if cmd_state = cmd_transfer_data then
			if iin.mcb_empty = '0' then
				wcount <= wcount + 1;
				iout.data <= iin.mcb_data;
			end if;
		end if;
	end if;
end process;

--Restart
process(clk)
begin
	if clk='1' and clk'Event then
		restarts <= restarts and not iin.restarted;
		if cmd_state = cmd_restart then
			restarts(to_integer(unsigned(cmd_tid))) <= '1';
		end if;
	end if;
end process;

--Send request
process(clk)
begin
	if clk='1' and clk'Event then
		iout.mcb_en <= '0';
		if state = ictl_req then
		--Send request to MCB
			iout.mcb_adr <= "0000" & icfifo_dout & (5 downto 0 => '0');
			iout.mcb_cmd <= "001";
			iout.mcb_bl <= "001111";      --64 bytes = 16 words - 1
			iout.mcb_en <= '1';
		end if;
	end if;
end process;


end Behavioral;

