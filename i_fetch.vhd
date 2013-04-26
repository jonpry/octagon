----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:10:14 04/23/2013 
-- Design Name: 
-- Module Name:    i_fetch - Behavioral 
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

entity i_fetch is
	Port ( 
		clk : in  std_logic;
		icin : in icfetchin_type;
		iout : out std_logic_vector(31 downto 0);
		idx : in std_logic_vector(2 downto 0)
	);
end i_fetch;

architecture Behavioral of i_fetch is

type itype is array(0 to 255) of std_logic_vector(31 downto 0);
signal iram : itype := (others => (others => '0'));

begin

process(clk)
begin
	if clk='1' and clk'Event then
		iout <= iram(to_integer(unsigned(icin.pcout.pc(9 downto 2))));
		if icin.imemwe = '1' and icin.imemidx = idx then
			iram(to_integer(unsigned(icin.imemadr))) <= icin.imemval;
		end if;
	end if;
end process;

end Behavioral;

