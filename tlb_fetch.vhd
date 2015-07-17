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
		tlbin : tlbin_type;
		fetchin : in tlbfetchin_type;
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
signal vasid : std_logic_vector(3 downto 0);
signal vsv : std_logic;
signal msize : std_logic;
signal masid : std_logic_vector(3 downto 0);
signal hmasid : std_logic_vector(3 downto 0);
signal hmsize : std_logic;
signal hmpage : std_logic_vector(IM_BITS-1 downto 12);

signal wrenq : std_logic := '0';

begin

process(clk)
	variable rdptr : integer;
	variable lrdptr : integer;
	variable hrdptr : integer;
	variable hlrdptr : integer;

	variable wrptr : integer;
	variable owns : std_logic;
	variable tasid : std_logic_vector(3 downto 0);
begin
	if clk='1' and clk'Event then
	
		rdptr := to_integer(unsigned(fetchin.vpage(16 downto 12)));
		lrdptr := to_integer(unsigned(vpage(16 downto 12)));
		hrdptr := to_integer(unsigned(fetchin.vpage(28 downto 24)));
		hlrdptr := to_integer(unsigned(vpage(28 downto 24)));

		vpage <= fetchin.vpage;
		vasid <= fetchin.vasid;
		vsv <= fetchin.vsv;
		
		mpage <= vtags(rdptr);
		msize <= huge_page(rdptr);
		masid <= asid(rdptr);

		hmpage <= vtags(hrdptr);
		hmsize <= huge_page(hrdptr);
		hmasid <= asid(hrdptr);

		tasid := masid;

		if hmsize='1' then
			tasid := hmasid;
			owns := to_std_logic(hmpage(IM_BITS-1 downto 24) = vpage(IM_BITS-1 downto 24));
			tlbout.perm <= perms(hlrdptr);
			tlbout.phys <= ptags(hlrdptr)(IM_BITS-1 downto 24) & vpage(23 downto 12);
		else
			owns := to_std_logic(mpage = vpage);
			tlbout.perm <= perms(lrdptr);
			tlbout.phys <= ptags(lrdptr);
		end if;

		tlbout.asid <= tasid;		
		owns := to_std_logic(owns = '1' and ((tasid = "1000" and vsv='1') or tasid = vasid));
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

