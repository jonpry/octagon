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

entity tlb_fetch is
	Port ( 
		clk : in  std_logic;
		tlbin : in tlbfetchin_type;
		tlbout : out tlbfetchout_type;
		idx : in std_logic_vector(1 downto 0)
	);
end tlb_fetch;

architecture Behavioral of tlb_fetch is

type asid_type is array(0 to 31) of std_logic_vector(3 downto 0); 
type perms_type is array(0 to 31) of std_logic_vector(2 downto 0);
type page_type is array(0 to 31) of std_logic_vector(IM_BITS-1 downto 12);

--Initialize to the invalid tag
signal vtags : page_type := (others => (others => '1'));
signal ptags : page_type := (others => (others => '1'));
signal huge_page : std_logic_vector(31 downto 0) := (others => '1');
signal asid : asid_type := (others => (others => '1'));
signal perms : perms_type := (others => (others => '1'));

signal mpage : std_logic_vector(IM_BITS-1 downto 12);
signal vpage : std_logic_vector(IM_BITS-1 downto 12);
signal msize : std_logic;
signal masid : std_logic_vector(3 downto 0);

signal wrenq : std_logic := '0';

begin

process(clk)
	variable rdptr : integer;
	variable lrdptr : integer;
	variable wrptr : integer;
	variable owns : std_logic;
begin
	if clk='1' and clk'Event then
	
		rdptr := to_integer(unsigned(tlbin.vpage(16 downto 12)));
		lrdptr := to_integer(unsigned(vpage(16 downto 12)));

		vpage <= tlbin.vpage;
		mpage <= vtags(rdptr);
		msize <= huge_page(rdptr);
		masid <= asid(rdptr);

		tlbout.perm <= perms(lrdptr);
		tlbout.phys <= ptags(lrdptr);

		if msize='1' then
			owns := to_std_logic(mpage(IM_BITS-1 downto 24) = vpage(IM_BITS-1 downto 24));
		else
			owns := to_std_logic(mpage = vpage);
		end if;
		
		owns := to_std_logic(owns = '1' and masid = tlbin.vasid);
		tlbout.owns <= owns;

		wrptr := to_integer(unsigned(tlbin.wradr));		
		wrenq <= '0';
		if tlbin.wren = '1' and tlbin.wridx = idx then
			vtags(wrptr) <= tlbin.virt;
			huge_page(wrptr) <= tlbin.size;
			asid(wrptr) <= tlbin.asid;
			wrenq <= '1';
		end if;
		
		if wrenq = '1' then
			ptags(wrptr) <= tlbin.phys;
			perms(wrptr) <= tlbin.perm;
		end if;
	end if;
end process;

end Behavioral;

