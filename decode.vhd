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

decout.r_s <= muxout.instr(25 downto 21);
--bltz and the like are comparizons against zero, so we force zero reg usage
decout.r_t <= muxout.instr(20 downto 16);
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
		decout.asid <= muxout.asid;
		decout.instr <= muxout.instr;
		decout.r_tz <= to_std_logic(muxout.instr(31 downto 26) = "000001"); 
	end if;
end process;

end Behavioral;

