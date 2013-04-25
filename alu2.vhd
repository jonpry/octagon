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
		
		if aluin.shift.amount(3) = '0' then
			shiftone := aluin.shift_part;
		else
			if aluin.shift.right = '0' then
				shiftone := aluin.shift_part(23 downto 0) & X"00";
			else
				shiftone(23 downto 0) := aluin.shift_part(31 downto 8);
				if aluin.shift.arith = '1' and aluin.shift_part(31) = '1' then
					shiftone(31 downto 24) := X"FF";
				else
					shiftone(31 downto 24) := X"00";
				end if;
			end if;
		end if;
		
		if aluin.shift.amount(2) = '0' then
			shifttwo := shiftone;
		else
			if aluin.shift.right = '0' then
				shifttwo := shiftone(27 downto 0) & X"0";
			else
				shifttwo(27 downto 0) := shiftone(31 downto 4);
				if aluin.shift.arith = '1' and aluin.shift_part(31) = '1' then
					shifttwo(31 downto 28) := X"F";
				else
					shifttwo(31 downto 28) := X"0";
				end if;
			end if;
		end if;
	
		if aluin.shift.amount(1) = '0' then
				shiftthree := shifttwo;
		else
			if aluin.shift.right = '0' then
				shiftthree := shifttwo(29 downto 0) & "00";
			else
				shiftthree(29 downto 0) := shifttwo(31 downto 2);
				if aluin.shift.arith = '1' and aluin.shift_part(31) = '1' then
					shiftthree(31 downto 30) := "11";
				else
					shiftthree(31 downto 30) := "00";
				end if;
			end if;
		end if;
		aluout.shift_part <= shiftthree;
	end if;
	
end process;

end Behavioral;

