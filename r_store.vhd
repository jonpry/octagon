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
		jumpout : in jumpout_type;
		rout : out rstoreout_type
	);
end r_store;

architecture Behavioral of r_store is

begin

--Control signals
process(clk)
begin
	if clk='1' and clk'Event then
		rout.tid <= jumpout.tid;
		rout.r_dest <= jumpout.r_dest;

		--TODO: need control signal
		if jumpout.reg_store = '1' or (jumpout.store_cond = '1' and jumpout.met = '1') then
			rout.valid <= to_std_logic(jumpout.valid='1' and jumpout.r_dest /= "00000");
		else
			rout.valid <= '0';
		end if;
	end if;
end process;

--Smux
process(clk)
begin
	if clk='1' and clk'Event then
		case jumpout.smux is
			when smux_shift	=> rout.smux <= jumpout.shiftout;
			when smux_jmux		=> rout.smux <= jumpout.mux;
			when smux_slt		=> rout.smux <= jumpout.slt;
		end case;
	end if;
end process;

end Behavioral;

