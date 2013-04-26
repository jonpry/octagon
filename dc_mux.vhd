----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:20:29 04/23/2013 
-- Design Name: 
-- Module Name:    ic_mux - Behavioral 
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
use work.octagon_funcs.all;

entity dc_mux is
	Port ( 
		clk : in  std_logic;
		fetchout : in dcfetchout_type;
		muxout : out dcmuxout_type
	);
end dc_mux;

architecture Behavioral of dc_mux is

begin

process(clk)
	variable sel : std_logic_vector(2 downto 0);
	variable selin : std_logic_vector(7 downto 0);
begin
	if clk='1' and clk'Event then

		selin := fetchout.owns;
		sel(0) := to_std_logic(selin(1)='1' or selin(3)='1' or selin(5)='1' or selin(7)='1');
		sel(1) := to_std_logic(selin(2)='1' or selin(3)='1' or selin(6)='1' or selin(7)='1');
		sel(2) := to_std_logic(selin(4)='1' or selin(5)='1' or selin(6)='1' or selin(7)='1');
		
		muxout.data <= fetchout.data(to_integer(unsigned(sel)));
	
	
		--TODO: this is a miss, need to handle it, dc stall is handled by jump module
		--if fetchout.owns = "00000000" then
		--	muxout.valid <= '0';
		--else
		--	muxout.valid <= fetchout.valid;
		--end if;
	end if;
end process;

end Behavioral;
