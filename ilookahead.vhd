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

entity ilookahead is
	Port ( 
		clk : in  std_logic;
		wr : in std_logic;
		din : in std_logic_vector(IM_BITS-1+4 downto 6); --ASID
		valid : in std_logic;
		match : out std_logic_vector(7 downto 0)
	);
end ilookahead;

architecture Behavioral of ilookahead is

type ram_type is array(0 to 7) of std_logic_vector(IM_BITS-1+4 downto 6); --ASID
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

			validshift(7) <= validshift(6);
			validshift(6) <= validshift(5);
			validshift(5) <= validshift(4);
			validshift(4) <= validshift(3);
			validshift(3) <= validshift(2);
			validshift(2) <= validshift(1);			
			validshift(1) <= validshift(0);
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

