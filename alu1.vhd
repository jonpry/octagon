----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:19:34 04/24/2013 
-- Design Name: 
-- Module Name:    alu1 - Behavioral 
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

entity alu1 is
	Port ( 
		clk : in  std_logic;
		rout : in rfetchout_type;
		aluout : out alu1out_type
	);
end alu1;

architecture Behavioral of alu1 is

begin
--Control signals
process(clk)
begin
	if clk='1' and clk'Event then
		aluout.pc <= rout.pc;
		aluout.tid <= rout.tid;
		aluout.valid <= rout.valid;
	end if;
end process;

--First stage barrel shift
process(clk)
	variable shamt : std_logic_vector(4 downto 0);
begin
	if clk='1' and clk'Event then
		shamt := rout.shift.amount;
		if rout.shift.reg = '1' then
			shamt := rout.r_s(4 downto 0);
		end if;
		
		aluout.shift <= rout.shift;
		aluout.shift.amount <= shamt;
		
		if shamt(4) = '0' then
			aluout.shift_part <= rout.r_t;
		else
			if rout.shift.right = '0' then
				aluout.shift_part <= rout.r_t(15 downto 0) & X"0000";
			else
				aluout.shift_part(15 downto 0) <= rout.r_t(31 downto 16);
				if rout.shift.arith = '1' and rout.r_t(31) = '1' then
					aluout.shift_part(31 downto 16) <= X"FFFF";
				else
					aluout.shift_part(31 downto 16) <= X"0000";
				end if;
			end if;
		end if;
	end if;
end process;


end Behavioral;

