----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:22:00 04/26/2013 
-- Design Name: 
-- Module Name:    dc_mem - Behavioral 
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

entity wb_master is
	Port ( 
		clk : in  std_logic;
		dcin : in dcmemin_type;
		wbout : out wbmout_type
	);
end wb_master;

architecture Behavioral of wb_master is

begin

process(clk)
begin
	if clk='1' and clk'Event then
		if dcin.dcout.nc = '1' and dcin.alu2out.valid = '1' and dcin.alu2out.dcwren = '1' then
			wbout.req <= '1';
			wbout.adr <= dcin.alu2out.dcwradr;
			wbout.data <= dcin.alu2out.store_data;
		else
			wbout.req <= '0';
		end if;
	end if;
end process;

end Behavioral;

