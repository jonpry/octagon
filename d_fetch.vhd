----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:10:14 04/23/2013 
-- Design Name: 
-- Module Name:    i_fetch - Behavioral 
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

entity d_fetch is
	Port ( 
		clk : in  std_logic;
		dcin : in dcmemin_type;
		dout : out std_logic_vector(31 downto 0);
		idx : in std_logic_vector(1 downto 0);
		idxi : in std_logic_vector(1 downto 0);
		way : in std_logic
	);
end d_fetch;

architecture Behavioral of d_fetch is

--Must use ramb18's on dcache or true dual port won't work
type dtype is array(0 to 511) of std_logic_vector(31 downto 0);
signal dram : dtype := (others => (others => '0'));

begin

process(clk)
begin
	if clk='1' and clk'Event then
		dout <= dram(to_integer(unsigned(way & dcin.alu2out.dcwradr(9 downto 2))));
		
		if dcin.alu2out.dcwren = '1' and dcin.dcout.owns(to_integer(unsigned(idx & way))) = '1' and dcin.alu2out.be(0) = '1' then
			dram(to_integer(unsigned(way & dcin.alu2out.dcwradr(9 downto 2))))(7 downto 0) <= dcin.alu2out.store_data(7 downto 0);
		end if;
		if dcin.alu2out.dcwren = '1' and dcin.dcout.owns(to_integer(unsigned(idx & way))) = '1' and dcin.alu2out.be(0) = '1' then
			dram(to_integer(unsigned(way & dcin.alu2out.dcwradr(9 downto 2))))(15 downto 8) <= dcin.alu2out.store_data(15 downto 8);
		end if;
		if dcin.alu2out.dcwren = '1' and dcin.dcout.owns(to_integer(unsigned(idx & way))) = '1' and dcin.alu2out.be(0) = '1' then
			dram(to_integer(unsigned(way & dcin.alu2out.dcwradr(9 downto 2))))(23 downto 16) <= dcin.alu2out.store_data(23 downto 16);
		end if;
		if dcin.alu2out.dcwren = '1' and dcin.dcout.owns(to_integer(unsigned(idx & way))) = '1' and dcin.alu2out.be(0) = '1' then
			dram(to_integer(unsigned(way & dcin.alu2out.dcwradr(9 downto 2))))(31 downto 24) <= dcin.alu2out.store_data(31 downto 24);
		end if;
		
		if dcin.dmemwe = '1' and idxi = idx then
			dram(to_integer(unsigned(dcin.dmemadr))) <= dcin.dmemval;
		end if;
	--TODO: this is all wrong. access to dcache ways must
	--be on same address for read and write
	--so we must delay the read on dcache until the way has been located
	--	if dcin.wren = '1' and dcin.owns(idxint) = '1' then
	--		dram(to_integer(unsigned(dcin.wradr(9 downto 2)))) <= dcin.data;
	--	end if;
	end if;
end process;

end Behavioral;

