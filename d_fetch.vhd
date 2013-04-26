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

entity d_fetch is
	Port ( 
		clk : in  std_logic;
		dcin : in dcfetchin_type;
		dout : out std_logic_vector(31 downto 0);
		idx : in std_logic_vector(2 downto 0)
	);
end d_fetch;

architecture Behavioral of d_fetch is

type dtype is array(0 to 255) of std_logic_vector(31 downto 0);
signal dram : dtype := (others => (others => '0'));

begin

process(clk)
begin
	if clk='1' and clk'Event then
		dout <= dram(to_integer(unsigned(dcin.adr(9 downto 2))));
		if dcin.dmemwe = '1' and dcin.dmemidx = idx then
			dram(to_integer(unsigned(dcin.dmemadr))) <= dcin.dmemval;
		end if;
	end if;
end process;

end Behavioral;

