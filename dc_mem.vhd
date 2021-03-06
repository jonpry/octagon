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
sel(0) <= to_std_logic(selin(1)='1' or selin(3)='1' or selin(5)='1' or selin(7)='1');
sel(1) <= to_std_logic(selin(2)='1' or selin(3)='1' or selin(6)='1' or selin(7)='1');
sel(2) <= to_std_logic(selin(4)='1' or selin(5)='1' or selin(6)='1' or selin(7)='1');
		
d_fetch0 : entity work.d_fetch port map(clk,dcin,dcout.data(0),"00",sel(2 downto 1),owns(1),dcout.dirty(0),dcout.ctl_data(0));
d_fetch1 : entity work.d_fetch port map(clk,dcin,dcout.data(1),"01",sel(2 downto 1),owns(3),dcout.dirty(1),dcout.ctl_data(1));
d_fetch2 : entity work.d_fetch port map(clk,dcin,dcout.data(2),"10",sel(2 downto 1),owns(5),dcout.dirty(2),dcout.ctl_data(2));
d_fetch3 : entity work.d_fetch port map(clk,dcin,dcout.data(3),"11",sel(2 downto 1),owns(7),dcout.dirty(3),dcout.ctl_data(3));


process(clk)
	variable miss : std_logic;
	variable dmiss : std_logic;
begin
	if clk='1' and clk'Event then
		miss := to_std_logic(dcin.dcout.owns = X"00"); --to_std_logic(dcin.dcout.sel = "000" and dcin.dcout.owns(0) = '0');
		dcout.sel <= sel(2 downto 1);
		dmiss := to_std_logic(miss='1' and (dcin.alu2out.load = '1' or dcin.alu2out.store = '1') and dcin.alu2out.valid='1');
		dcout.tid <= dcin.alu2out.tid;
		dcout.adr <= dcin.dcout.adr;
		if dcin.dcout.dcache_op = '1' and dcin.dcout.cache_p = '0' then
			--create cache address from hit data. upper bits are dnc			
			dcout.adr(12 downto 10) <= sel;
		end if;
		
		dcout.dmiss <= dmiss;
		--Do not report as a miss if the way location is explicit
		if dcin.dcout.dcache_op = '1' and dcin.dcout.cache_p = '1' then
			dcout.dmiss <= '0';
		end if;


		dcout.do_op <= to_std_logic((dmiss = '1' and dcin.dcout.nc = '0') or dcin.dcout.dcache_op = '1');
		dcout.cacheop <= dcin.dcout.cacheop;
		dcout.dcache_op <= dcin.dcout.dcache_op;
	end if;
end process;

end Behavioral;

