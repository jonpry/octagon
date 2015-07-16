----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:32:16 04/29/2013 
-- Design Name: 
-- Module Name:    ilookahead - Behavioral 
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

entity tlb is
	Port ( 
		clk : in  std_logic;
		tlbind : in tlbin_type;
		tlboutd : out tlbout_type
	);
end tlb;

architecture Behavioral of tlb is

type fetchout_type is array(0 to 3) of tlbfetchout_type; 
type fetchin_type is array(0 to 3) of tlbfetchin_type; 

signal fetchout : fetchout_type;
signal fetchin : fetchin_type;

signal tlbin : tlbin_type;
signal tlbout : tlbout_type;

signal iack, iackq, iackqq : std_logic := '0';
signal dack, dackq, dackqq : std_logic := '0';

begin

gen_assoc_array: FOR i IN 0 to 3 generate
	tlb_tagfetch : entity work.tlb_fetch port map(clk, fetchin(i), fetchout(i), std_logic_vector(to_unsigned(i,2)));
	fetchin(i).asid <= tlbin.asid;
	fetchin(i).perm <= tlbin.perm;
	fetchin(i).phys <= tlbin.phys;
	fetchin(i).virt <= tlbin.virt;
	fetchin(i).size <= tlbin.size;
	fetchin(i).wren <= tlbin.wren;
	fetchin(i).wradr <= tlbin.wradr;
	fetchin(i).wridx <= tlbin.wridx;
end  generate;

process(clk)
	variable selin : std_logic_vector(3 downto 0);
	variable sel : std_logic_vector(1 downto 0);
	variable muxadr : integer;
begin
	if clk='1' and clk'Event then
		tlbin <= tlbind;
		tlboutd <= tlbout;
	
		selin := fetchout(3).owns & fetchout(2).owns & fetchout(1).owns & fetchout(0).owns;
		sel(0) := to_std_logic(selin(1)='1' or selin(3)='1');
		sel(1) := to_std_logic(selin(2)='1' or selin(3)='1');
		muxadr := to_integer(unsigned(sel));
		
		tlbout.hit <= to_std_logic(selin /= "0000");
		tlbout.phys <= fetchout(muxadr).phys;
		tlbout.perm <= fetchout(muxadr).perm;
		tlbout.asid <= fetchout(muxadr).asid;
		
		iack <= tlbin.ireq;
		dack <= to_std_logic(tlbin.dreq = '1' and tlbin.ireq='0');
		
		iackq <= iack;
		dackq <= dack;
		
		iackqq <= iackq;
		dackqq <= dackq;
		
		tlbout.iack <= iackqq;
		tlbout.dack <= iackqq;
		
		for i in 0 to 3 loop
			if tlbin.ireq = '1' then
			   fetchin(i).vsv <= tlbin.isv;
				fetchin(i).vasid <= tlbin.iasid;
				fetchin(i).vpage <= tlbin.ivaddr(IM_BITS-1 downto 12);
			else
			   fetchin(i).vsv <= tlbin.dsv;
				fetchin(i).vasid <= tlbin.dasid;
				fetchin(i).vpage <= tlbin.dvaddr(IM_BITS-1 downto 12);			
			end if;
		end loop;
	
	end if;
end process;

end Behavioral;

