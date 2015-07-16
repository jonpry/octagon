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

entity ic_fetch is
	Port ( 
		clk : in  std_logic;
		icin : in icfetchin_type;
		icout : out icfetchout_type
	);
end ic_fetch;

architecture Behavioral of ic_fetch is

type pc_type is array(0 to 7) of std_logic_vector(IM_BITS-1 downto 0);

signal pcsave : pc_type := (others => (others => '1'));

begin

--8192 byte cache organized as 8 ways of 1024 bytes (9 downto 0)
--Lines are 64bytes, (5 downto 0)
--16 lines per way

tag_fetch0 : entity work.tag_fetch port map(clk,icin,"000",icout.owns(0),icout.ownsp(0),icout.ownst(0));
tag_fetch1 : entity work.tag_fetch port map(clk,icin,"001",icout.owns(1),icout.ownsp(1),icout.ownst(1));
tag_fetch2 : entity work.tag_fetch port map(clk,icin,"010",icout.owns(2),icout.ownsp(2),icout.ownst(2));
tag_fetch3 : entity work.tag_fetch port map(clk,icin,"011",icout.owns(3),icout.ownsp(3),icout.ownst(3));
tag_fetch4 : entity work.tag_fetch port map(clk,icin,"100",icout.owns(4),icout.ownsp(4),icout.ownst(4));
tag_fetch5 : entity work.tag_fetch port map(clk,icin,"101",icout.owns(5),icout.ownsp(5),icout.ownst(5));
tag_fetch6 : entity work.tag_fetch port map(clk,icin,"110",icout.owns(6),icout.ownsp(6),icout.ownst(6));
tag_fetch7 : entity work.tag_fetch port map(clk,icin,"111",icout.owns(7),icout.ownsp(7),icout.ownst(7));

i_fetch0 : entity work.i_fetch port map(clk,icin,icout.instr(0),"000");
i_fetch1 : entity work.i_fetch port map(clk,icin,icout.instr(1),"001");
i_fetch2 : entity work.i_fetch port map(clk,icin,icout.instr(2),"010");
i_fetch3 : entity work.i_fetch port map(clk,icin,icout.instr(3),"011");
i_fetch4 : entity work.i_fetch port map(clk,icin,icout.instr(4),"100");
i_fetch5 : entity work.i_fetch port map(clk,icin,icout.instr(5),"101");
i_fetch6 : entity work.i_fetch port map(clk,icin,icout.instr(6),"110");
i_fetch7 : entity work.i_fetch port map(clk,icin,icout.instr(7),"111");

process(clk)
begin
	if clk='1' and clk'Event then
		icout.pc <= icin.pcout.pc;
		icout.tid <= icin.pcout.tid;
		icout.valid <= to_std_logic(icin.pcout.valid='1' and icin.pcout.abort='0');
		icout.asid <= icin.pcout.asid;
		icout.tlb <= icin.pcout.tlb;
		icout.exc <= icin.pcout.exc;
		icout.ksu <= icin.pcout.ksu;
		icout.sv <= icin.pcout.sv;
		
		icout.ibuf_match <= '0';
		if icin.pcout.valid = '1' then
			pcsave(to_integer(unsigned(icin.pcout.tid))) <= icin.pcout.pc;
		end if;
		if pcsave(to_integer(unsigned(icin.pcout.tid))) = icin.pcout.pc then
			icout.ibuf_match <= '1';
		end if;
	end if;
end process;

end Behavioral;

