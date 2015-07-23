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
use work.octagon_funcs.all;

entity alt_d_fetch is
	Port ( 
		clk : in  std_logic;
		dcin : in dcmemin_type;
		dout : out std_logic_vector(31 downto 0);
		idx : in std_logic_vector(1 downto 0);
		idxi : in std_logic_vector(1 downto 0);
		way : in std_logic;
		dirt : out std_logic;
		cout : out std_logic_vector(31 downto 0)
	);
end alt_d_fetch;

architecture Behavioral of alt_d_fetch is

--Must use ramb18's on dcache or true dual port won't work
type word_t is array (0 to 3) of std_logic_vector(7 downto 0);
type dtype is array(0 to 511) of word_t;
signal dram : dtype := (others => (others => (others => '0')));

signal coutw, doutw : word_t;

signal dirty : std_logic_vector(31 downto 0) := (others => '0');
signal wren,wrenb : std_logic;

signal aadr : Integer;
signal badr : Integer;
 
signal be : std_logic_vector(3 downto 0) := (others => '1');

attribute ram_style: string;
attribute ram_style of dirty : signal is "distributed";

attribute ramstyle : string;
attribute ramstyle of dram : signal is "no_rw_check";


begin

unpack: for i in 0 to 3 generate
	dout(8*(i+1) - 1 downto 8*i) <= doutw(i);
	cout(8*(i+1) - 1 downto 8*i) <= coutw(i);
end generate unpack;

wrenb <= to_std_logic(dcin.dmemwe = '1' and dcin.dmemidx(2 downto 1) = idx);
wren <= to_std_logic(dcin.alu2out.dcwren='1' and 
					dcin.dcout.owns(to_integer(unsigned(idx & way)))='1');
aadr <= to_integer(unsigned(way & dcin.alu2out.dcwradr(9 downto 2)));
badr <= to_integer(unsigned(dcin.dmemidx(0) & dcin.dmemadr));

					
process(clk)
	variable nc : std_logic;
begin
	if clk='1' and clk'Event then
	
		if wren = '1' then
			dirty(to_integer(unsigned(way & dcin.alu2out.dcwradr(9 downto 6)))) <= '1';
		end if;
				
		if wren = '1' then
			if dcin.alu2out.be(0) = '1' then
				dram(aadr)(0) <= dcin.alu2out.store_data(7 downto 0);
			end if;
			if dcin.alu2out.be(1) = '1' then
				dram(aadr)(1) <= dcin.alu2out.store_data(15 downto 8);
			end if;
			if dcin.alu2out.be(2) = '1' then
				dram(aadr)(2) <= dcin.alu2out.store_data(23 downto 16);
			end if;
			if dcin.alu2out.be(3) = '1' then
				dram(aadr)(3) <= dcin.alu2out.store_data(31 downto 24);
			end if;
			doutw <= (others =>(others => 'X'));
		else
			doutw <= dram(aadr);		
		end if;
		
		if dcin.dclean = '1' and dcin.dmemidx(2 downto 1) = idx then
			dirty(to_integer(unsigned(dcin.dmemidx(0) & dcin.dmemadr(7 downto 4)))) <= '0';
		end if;
		
		dirt <= dirty(to_integer(unsigned(dcin.dmemidx(0) & dcin.dmemadr(7 downto 4))));
	end if;
end process;

process(clk) begin
	if rising_edge(clk) then
		--Second port stuffs
		if wrenb='1' then
				dram(badr)(0) <= dcin.dmemval(7 downto 0);
				dram(badr)(1) <= dcin.dmemval(15 downto 8);
				dram(badr)(2) <= dcin.dmemval(23 downto 16);
				dram(badr)(3) <= dcin.dmemval(31 downto 24);
			coutw <= (others=> (others => 'X'));
		else
		coutw <= dram(badr);
		end if;
	end if;
end process;

end Behavioral;

