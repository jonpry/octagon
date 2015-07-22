library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

library work;

use work.octagon_types.all;
use work.octagon_funcs.all;

entity test is
port (
	clk : in std_logic;
	raddr : in integer range 0 to 511 ; -- address width = 6
	be : in std_logic_vector (3 downto 0); -- 4 bytes per word
	wdata : in std_logic_vector(31 downto 0); -- byte width = 8
	
		dcin : in dcmemin_type;
		dout : out std_logic_vector(31 downto 0);
		idx : in std_logic_vector(1 downto 0);
		idxi : in std_logic_vector(1 downto 0);
		way : in std_logic;
		dirt : out std_logic;
		cout : out std_logic_vector(31 downto 0)
	); -- byte width = 8
end test;

architecture rtl of test is

--Must use ramb18's on dcache or true dual port won't work
type word_t is array (0 to 3) of std_logic_vector(7 downto 0);
type dtype is array(0 to 511) of word_t;
signal dram : dtype := (others => (others => (others => '0')));

signal doutw : word_t;

signal dirty : std_logic_vector(31 downto 0) := (others => '0');
signal wren : std_logic;
signal wradr : integer;

attribute ram_style: string;
attribute ram_style of dirty : signal is "distributed";


begin -- Re-organize the read data from the RAM to match the output

unpack: for i in 0 to 3 generate
	dout(8*(i+1) - 1 downto 8*i) <= doutw(i);
end generate unpack;

wren <= to_std_logic(dcin.alu2out.dcwren='1' and 
					dcin.dcout.owns(to_integer(unsigned(idx & way)))='1');
					
wradr <= to_integer(unsigned(way & dcin.alu2out.dcwradr(9 downto 2)));


process(clk)
begin
	if(rising_edge(clk)) then
		if(wren = '1') then
			if dcin.alu2out.be(0) = '1' then
				dram(wradr)(0) <= dcin.alu2out.store_data(7 downto 0);
			end if;
			if dcin.alu2out.be(1) = '1' then
				dram(wradr)(1) <= dcin.alu2out.store_data(15 downto 8);
			end if;
			if dcin.alu2out.be(2) = '1' then
				dram(wradr)(2) <= dcin.alu2out.store_data(23 downto 16);
			end if;
			if dcin.alu2out.be(3) = '1' then
				dram(wradr)(3) <= dcin.alu2out.store_data(31 downto 24);
			end if;
		end if;
		doutw <= dram(raddr);
	end if;
end process;

end rtl;
