----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:00 04/23/2013 
-- Design Name: 
-- Module Name:    ic_fetch - Behavioral 
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

entity dc_fetch is
	Port ( 
		clk : in  std_logic;
		dcin : in dcfetchin_type;
		dcout : out dcfetchout_type
	);
end dc_fetch;

architecture Behavioral of dc_fetch is
begin

--8192 byte cache organized as 8 ways of 1024 bytes (9 downto 0)
--Lines are 64bytes, (5 downto 0)
--16 lines per way

tag_fetch0 : entity work.dtag_fetch port map(clk,dcin,"000",dcout.owns(0));
tag_fetch1 : entity work.dtag_fetch port map(clk,dcin,"001",dcout.owns(1));
tag_fetch2 : entity work.dtag_fetch port map(clk,dcin,"010",dcout.owns(2));
tag_fetch3 : entity work.dtag_fetch port map(clk,dcin,"011",dcout.owns(3));
tag_fetch4 : entity work.dtag_fetch port map(clk,dcin,"100",dcout.owns(4));
tag_fetch5 : entity work.dtag_fetch port map(clk,dcin,"101",dcout.owns(5));
tag_fetch6 : entity work.dtag_fetch port map(clk,dcin,"110",dcout.owns(6));
tag_fetch7 : entity work.dtag_fetch port map(clk,dcin,"111",dcout.owns(7));

end Behavioral;

