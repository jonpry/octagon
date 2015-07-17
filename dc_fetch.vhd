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
use work.octagon_funcs.all;

entity dc_fetch is
	Port ( 
		clk : in  std_logic;
		dcin : in dcfetchin_type;
		dcout : out dcfetchout_type
	);
end dc_fetch;

architecture Behavioral of dc_fetch is

signal owns : std_logic_vector(7 downto 0);

signal tag : tag_type;

signal mntn_restarts : std_logic_vector(7 downto 0) := X"00";

attribute ram_style: string;
attribute ram_style of mntn_restarts : signal is "distributed";

begin

--8192 byte cache organized as 8 ways of 1024 bytes (9 downto 0)
--Lines are 64bytes, (5 downto 0)
--16 lines per way

tag_fetch0 : entity work.dtag_fetch port map(clk,dcin,"000",owns(0),tag(0),dcout.ptag(0),dcout.ownst(0),dcout.ownsp(0),dcout.phys(0));
tag_fetch1 : entity work.dtag_fetch port map(clk,dcin,"001",owns(1),tag(1),dcout.ptag(1),dcout.ownst(1),dcout.ownsp(1),dcout.phys(1));
tag_fetch2 : entity work.dtag_fetch port map(clk,dcin,"010",owns(2),tag(2),dcout.ptag(2),dcout.ownst(2),dcout.ownsp(2),dcout.phys(2));
tag_fetch3 : entity work.dtag_fetch port map(clk,dcin,"011",owns(3),tag(3),dcout.ptag(3),dcout.ownst(3),dcout.ownsp(3),dcout.phys(3));
tag_fetch4 : entity work.dtag_fetch port map(clk,dcin,"100",owns(4),tag(4),dcout.ptag(4),dcout.ownst(4),dcout.ownsp(4),dcout.phys(4));
tag_fetch5 : entity work.dtag_fetch port map(clk,dcin,"101",owns(5),tag(5),dcout.ptag(5),dcout.ownst(5),dcout.ownsp(5),dcout.phys(5));
tag_fetch6 : entity work.dtag_fetch port map(clk,dcin,"110",owns(6),tag(6),dcout.ptag(6),dcout.ownst(6),dcout.ownsp(6),dcout.phys(6));
tag_fetch7 : entity work.dtag_fetch port map(clk,dcin,"111",owns(7),tag(7),dcout.ptag(7),dcout.ownst(7),dcout.ownsp(7),dcout.phys(7));

dcout.tagdemux <= tag;
dcout.sel(0) <= to_std_logic(owns(1)='1' or owns(3)='1' or owns(5)='1' or owns(7)='1');
dcout.sel(1) <= to_std_logic(owns(2)='1' or owns(3)='1' or owns(6)='1' or owns(7)='1');
dcout.sel(2) <= to_std_logic(owns(4)='1' or owns(5)='1' or owns(6)='1' or owns(7)='1');
dcout.owns <= owns;

process(clk)
	variable restart : std_logic;
begin
	if clk='1' and clk'Event then
		restart := mntn_restarts(to_integer(unsigned(dcin.tid)));
	
		dcout.adr <= dcin.adr;
		dcout.sv <= dcin.sv;
		dcout.tlb <= dcin.tlb;
		
		--dcout.miss <= to_std_logic(owns = X"00");

	--Catch accesses to non cached memory
		--dcout.nc <= to_std_logic(dcin.adr(DM_BITS-1 downto DM_BITS-2) /= "00");
		
		dcout.tag <= tag(to_integer(unsigned(dcin.tagidx)));
		
		dcout.cacheop <= dcin.cacheop;
		dcout.dcache_op <= to_std_logic(dcin.dcache_op = '1' and restart = '0');
		dcout.cache_p <= dcin.cache_p;
	
		if dcin.dcache_op = '1' then
			mntn_restarts(to_integer(unsigned(dcin.tid))) <= '0';
		end if;
	
		if dcin.mntn_restart = '1' then
			mntn_restarts(to_integer(unsigned(dcin.mntn_tid))) <= '1';
		end if;
	end if;
end process;

end Behavioral;

