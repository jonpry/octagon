----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:20:00 04/23/2013 
-- Design Name: 
-- Module Name:    tag_fetch - Behavioral 
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

entity tag_fetch is
	Port ( 
		clk : in  std_logic;
		icin : in icfetchin_type;
		idx : in std_logic_vector(2 downto 0);
		own : out std_logic
	);
end tag_fetch;

architecture Behavioral of tag_fetch is

--Ram to store Tags
signal tagram : tag_type := (others => (others => '0'));
signal tagadr : std_logic_vector(3 downto 0);

begin

tagadr <= icin.pcout.pc(9 downto 6);

process(clk)
	variable this_tag : std_logic_vector(IM_BITS-1 downto 10);
begin
	if clk='1' and clk'Event then
		this_tag := tagram(to_integer(unsigned(tagadr)));
		if this_tag = icin.pcout.pc(IM_BITS-1 downto 10) then
			own <= '1';
		else
			own <= '0';
		end if;
		if icin.tagwe = '1' and icin.tagidx = idx then
			tagram(to_integer(unsigned(icin.tagadr))) <= icin.tagval;
		end if;
	end if;
end process;

end Behavioral;

