----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:00:53 04/24/2013 
-- Design Name: 
-- Module Name:    alu2 - Behavioral 
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

entity alu2 is
	Port ( 
		clk : in  std_logic;
		aluin : in alu1out_type;
		aluout : out alu2out_type
	);
end alu2;

architecture Behavioral of alu2 is

begin

--Control signals
process(clk)
begin
	if clk='1' and clk'Event then
		aluout.pc <= aluin.pc;
		aluout.tid <= aluin.tid;
		aluout.valid <= aluin.valid;
	end if;
end process;

--Barrel shift stage
process(clk)
	variable shiftone : std_logic_vector(31 downto 0);
	variable shifttwo : std_logic_vector(31 downto 0);
	variable shiftthree : std_logic_vector(31 downto 0);
begin
	if clk='1' and clk'Event then
		aluout.shift <= aluin.shift;
		
		shiftone   := shift(16,aluin.shift_part,aluin.shift.op,aluin.shift.amount(4));
		shifttwo   := shift(8,shiftone,aluin.shift.op,aluin.shift.amount(3));
		shiftthree := shift(4,shifttwo,aluin.shift.op,aluin.shift.amount(2));

		aluout.shift_part <= shiftthree;
	end if;
	
end process;

end Behavioral;

