----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:45:10 04/26/2013 
-- Design Name: 
-- Module Name:    r_store - Behavioral 
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

entity r_store is
	Port ( 
		clk : in  std_logic;
		lmuxout : in lmuxout_type;
		rout : out rstoreout_type
	);
end r_store;

architecture Behavioral of r_store is

begin

--Control signals
rout.tid <= lmuxout.tid;
rout.r_dest <= lmuxout.r_dest;
rout.valid <= lmuxout.valid;

--Smux
rout.smux <= lmuxout.loadv when lmuxout.load = '1' else lmuxout.lmux;

end Behavioral;

