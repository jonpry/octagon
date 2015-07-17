----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:20:00 04/23/2013 
-- Design Name: 
-- Module Name:    tag_fetch - Behavioral 
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

entity dtag_fetch is
	Port ( 
		clk : in  std_logic;
		dcin : in dcfetchin_type;
		idx : in std_logic_vector(2 downto 0);
		own : out std_logic;
		tag : out std_logic_vector(DM_BITS-1+4 downto 10);
		ptag : out std_logic_vector(DM_BITS-1 downto 12);
		ownt : out std_logic;
		ownp : out std_logic;
		phys : out std_logic
	);
end dtag_fetch;

architecture Behavioral of dtag_fetch is

--Ram to store Tags
signal tagram : tag_type := (others => (others => '1'));
signal ptagram : ptag_type := (others => (others => '1'));
signal tagadr : std_logic_vector(3 downto 0);
signal kram : std_logic_vector(15 downto 0) := (others => '0');
--signal this_tag : std_logic_vector(DM_BITS-1+4 downto 10); --ASID

begin

tagadr <= dcin.adr(9 downto 6);

--this_tag <= tagram(to_integer(unsigned(tagadr)));
--own <= '1' when this_tag(DM_BITS-1+4 downto DM_BITS) = dcin.asid and this_tag(DM_BITS-1 downto 10) = dcin.adr(DM_BITS-1 downto 10) else '0';

process(clk)
     variable ptagv : std_logic_vector(IM_BITS-1 downto 12);
	  variable this_tag : std_logic_vector(IM_BITS-1+4 downto 10);
	  variable this_k : std_logic;
begin
	if clk='1' and clk'Event then
		tag <= tagram(to_integer(unsigned(dcin.tagadr)))(IM_BITS-1+4 downto IM_BITS) & ptagram(to_integer(unsigned(dcin.tagadr))) & tagram(to_integer(unsigned(dcin.tagadr)))(11 downto 10);

		this_tag := tagram(to_integer(unsigned(tagadr)));
		this_k := kram(to_integer(unsigned(tagadr)));
		own <= to_std_logic((this_tag(DM_BITS-1+4 downto DM_BITS) = dcin.asid or 
						(this_k = '1' and dcin.sv = '1')) and this_tag(DM_BITS-1 downto 10) = dcin.adr(DM_BITS-1 downto 10));
		
		ptagv := ptagram(to_integer(unsigned(tagadr)));
		ptag <= ptagv;
		phys <= ptagv(IM_BITS-1);
		ownt <= '0';
		ownp <= '0';
		if dcin.tagwe = '1' and dcin.tagidx = idx then
			tagram(to_integer(unsigned(dcin.tagadr))) <= dcin.tagval;
			kram(to_integer(unsigned(dcin.tagadr))) <= to_std_logic(dcin.tagval(IM_BITS-1+4 downto IM_BITS) = "1000");
			ptagram(to_integer(unsigned(dcin.tagadr))) <= dcin.tagphys;
		else
			this_tag := tagram(to_integer(unsigned(dcin.tagadr)));
			this_k := kram(to_integer(unsigned(dcin.tagadr)));
			if (this_tag(IM_BITS-1+4 downto IM_BITS) = dcin.tagval(IM_BITS-1+4 downto IM_BITS)
					or (this_k = '1' and dcin.tagsv = '1')) and this_tag(IM_BITS-1 downto 10) = dcin.tagval(IM_BITS-1 downto 10) then
				ownt <= '1';
			end if;
			if ptagram(to_integer(unsigned(dcin.tagadr))) = dcin.tagphys then
				ownp <= '1';
			end if;
		end if;
	end if;
end process;

end Behavioral;

