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

entity dc_mem is
	Port ( 
		clk : in  std_logic;
		dcin : in dcmemin_type;
		dcout : out dcmemout_type
	);
end dc_mem;

architecture Behavioral of dc_mem is

signal selin : std_logic_vector(7 downto 0);
signal sel : std_logic_vector(2 downto 0);
signal owns : std_logic_vector(7 downto 0);

begin

--sel <= dcin.dcout.sel;
owns <= dcin.dcout.owns;
selin <= dcin.dcout.owns;
--sel(0) <= to_std_logic(selin(1)='1' or selin(3)='1' or selin(5)='1' or selin(7)='1');
sel(1) <= to_std_logic(selin(2)='1' or selin(3)='1' or selin(6)='1' or selin(7)='1');
sel(2) <= to_std_logic(selin(4)='1' or selin(5)='1' or selin(6)='1' or selin(7)='1');
		
d_fetch0 : entity work.d_fetch port map(clk,dcin,dcout.data(0),"00",sel(2 downto 1),owns(1));
d_fetch1 : entity work.d_fetch port map(clk,dcin,dcout.data(1),"01",sel(2 downto 1),owns(3));
d_fetch2 : entity work.d_fetch port map(clk,dcin,dcout.data(2),"10",sel(2 downto 1),owns(5));
d_fetch3 : entity work.d_fetch port map(clk,dcin,dcout.data(3),"11",sel(2 downto 1),owns(7));


process(clk)
begin
	if clk='1' and clk'Event then
		dcout.sel <= sel(2 downto 1);
		dcout.dmiss <= to_std_logic(owns = X"00" and (dcin.alu2out.load = '1' or dcin.alu2out.store = '1') and dcin.alu2out.valid='1');
		dcout.tid <= dcin.alu2out.tid;
		dcout.adr <= dcin.dcout.adr;
	end if;
end process;

end Behavioral;

