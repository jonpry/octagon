----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:22 04/29/2013 
-- Design Name: 
-- Module Name:    ic_fifo - Behavioral 
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

entity dc_fifo is
	Port ( 
		clk : in  std_logic;
		rd	: in std_logic;
		wr : in std_logic;
		tidi : in std_logic_vector(2 downto 0);
		din : in std_logic_vector(IM_BITS-1 downto 6);
		missi : in std_logic;
		mntni : in std_logic;
		opi : in cacheop_type;
		dout : out std_logic_vector(IM_BITS-1 downto 6);
		tido : out std_logic_vector(2 downto 0);
		misso : out std_logic;
		mntno : out std_logic;
		opo : out cacheop_type;
		empty : out std_logic
	);
end dc_fifo;

architecture Behavioral of dc_fifo is

--TODO: !!!!this fifo can only store 7 pending stalls!

type fd_type is array(0 to 7) of std_logic_vector(IM_BITS-1 downto 6);
type tid_type is array(0 to 7) of std_logic_vector(2 downto 0);
type cop_type is array(0 to 7) of cacheop_type;


signal fifo_data : fd_type := (others => (others => '0'));
signal fifo_tiddata : tid_type := (others => (others => '0'));
signal fifo_copdata : cop_type;
signal fifo_missdata : std_logic_vector(7 downto 0);
signal fifo_mntndata : std_logic_vector(7 downto 0);


signal rdptr : unsigned(3 downto 0) := "0000";
signal wrptr : unsigned(3 downto 0) := "0000";

begin

process(clk)
	variable rdI : Integer;
	variable wrI : Integer;
begin
	if clk='1' and clk'Event then
		empty <= to_std_logic(rdptr = wrptr);	
		rdI := to_integer(rdptr(2 downto 0));
		dout <= fifo_data(rdI);
		tido <= fifo_tiddata(rdI);
		opo <= fifo_copdata(rdI);
		mntno <= fifo_mntndata(rdI);
		misso <= fifo_missdata(rdI);
		
		if rd='1' then
			rdptr <= rdptr + 1;
		end if;
		
		if wr='1' then
			wrI := to_integer(wrptr(2 downto 0));
			fifo_data(wrI) <= din;
			fifo_tiddata(wrI) <= tidi;
			fifo_copdata(wrI) <= opi;
			fifo_mntndata(wrI) <= mntni;
			fifo_missdata(wrI) <= missi;
			wrptr <= wrptr + 1;
		end if;
	end if;
end process;

end Behavioral;

