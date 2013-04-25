----------------------------------------------------------------------------------
-- Company: Pry Mfg Co
-- Engineer: Jon Pry
-- 
-- Create Date:    23:52:35 04/24/2013 
-- Design Name: 
-- Module Name:    jump - Behavioral 
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

entity jump is
	Port ( 
		clk : in std_logic;
		aluin : in alu2out_type;
		jumpout : out jumpout_type
	);
end jump;

architecture Behavioral of jump is

begin

process(clk)
begin
	if clk='1' and clk'Event then
		jumpout.tid <= aluin.tid;
		jumpout.valid <= aluin.valid;
		jumpout.pc <= aluin.pc;
	end if;
end process;

end Behavioral;

