----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:38:04 04/23/2013 
-- Design Name: 
-- Module Name:    decode - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.octagon_types.all;
use work.octagon_funcs.all;

entity decode is
	Port ( 
		clk : in  std_logic;
		muxout : in icmuxout_type;
		decout : out decout_type
	);
end decode;

architecture Behavioral of decode is

begin

--mfc0 needs to perform a move instruction which is emulated through
--the add pipeline by using the zero register
decout.r_s <= "00000" when muxout.instr(31 downto 26) = "010000" --cop0
					else muxout.instr(25 downto 21);
--bltz and the like are comparizons against zero, so we force zero reg usage
decout.r_t <= "00000" when muxout.instr(31 downto 26) = "000001" else muxout.instr(20 downto 16);
decout.ftid <= muxout.tid;

process(clk)
variable opcode : std_logic_vector(5 downto 0);
variable func : std_logic_vector(5 downto 0);
variable instr : std_logic_vector(31 downto 0);
variable opzero : std_logic;
begin
	if clk='1' and clk'Event then
		decout.pc <= muxout.pc;
		decout.valid <= muxout.valid;
		decout.tid <= muxout.tid;
		decout.instr <= muxout.instr;
	end if;
end process;

end Behavioral;

