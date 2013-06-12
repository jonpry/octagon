----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:32:16 04/29/2013 
-- Design Name: 
-- Module Name:    ilookahead - Behavioral 
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

entity dlookahead is
	Port ( 
		clk : in  std_logic;
		wr : in std_logic;
		din : in std_logic_vector(IM_BITS-1 downto 6);
		valid : in std_logic;
		invalidate : in std_logic_vector(7 downto 0);
		match : out std_logic_vector(7 downto 0)
	);
end dlookahead;

architecture Behavioral of dlookahead is

type ram_type is array(0 to 7) of std_logic_vector(IM_BITS-1 downto 6);
--Initialize to the invalid tag
signal shiftreg : ram_type := (others => (others => '1'));
signal validshift : std_logic_vector(7 downto 0) := X"00";

begin

process(clk)
begin
	if clk='1' and clk'Event then
		if wr = '1' then
			shiftreg(7) <= shiftreg(6);
			shiftreg(6) <= shiftreg(5);
			shiftreg(5) <= shiftreg(4);
			shiftreg(4) <= shiftreg(3);
			shiftreg(3) <= shiftreg(2);
			shiftreg(2) <= shiftreg(1);
			shiftreg(1) <= shiftreg(0);
			shiftreg(0) <= din;

			validshift(7) <= to_std_logic(validshift(6)='1' and invalidate(6)='0');
			validshift(6) <= to_std_logic(validshift(5)='1' and invalidate(5)='0');
			validshift(5) <= to_std_logic(validshift(4)='1' and invalidate(4)='0');
			validshift(4) <= to_std_logic(validshift(3)='1' and invalidate(3)='0');
			validshift(3) <= to_std_logic(validshift(2)='1' and invalidate(2)='0');
			validshift(2) <= to_std_logic(validshift(1)='1' and invalidate(1)='0');			
			validshift(1) <= to_std_logic(validshift(0)='1' and invalidate(0)='0');
			validshift(0) <= valid;
		end if;
		
		match(0) <= to_std_logic(shiftreg(0) = din and validshift(0) = '1');
		match(1) <= to_std_logic(shiftreg(1) = din and validshift(1) = '1');
		match(2) <= to_std_logic(shiftreg(2) = din and validshift(2) = '1');
		match(3) <= to_std_logic(shiftreg(3) = din and validshift(3) = '1');
		match(4) <= to_std_logic(shiftreg(4) = din and validshift(4) = '1');
		match(5) <= to_std_logic(shiftreg(5) = din and validshift(5) = '1');
		match(6) <= to_std_logic(shiftreg(6) = din and validshift(6) = '1');
		match(7) <= to_std_logic(shiftreg(7) = din and validshift(7) = '1');

	end if;
end process;

end Behavioral;

