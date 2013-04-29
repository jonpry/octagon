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

entity icmd_fifo is
	Port ( 
		clk : in  std_logic;
		rd	: in std_logic;
		wr : in std_logic;
		tidi : in std_logic_vector(2 downto 0);
		fakei : in std_logic;
		din : in std_logic_vector(IM_BITS-1 downto 6);
		dout : out std_logic_vector(IM_BITS-1 downto 6);
		tido : out std_logic_vector(2 downto 0);
		fakeo : out std_logic;
		empty : out std_logic
	);
end icmd_fifo;

architecture Behavioral of icmd_fifo is

type fd_type is array(0 to 7) of std_logic_vector(IM_BITS-1 downto 6);
type tid_type is array(0 to 7) of std_logic_vector(2 downto 0);

signal fifo_data : fd_type := (others => (others => '0'));
signal fifo_tiddata : tid_type := (others => (others => '0'));
signal fake_data : std_logic_vector(7 downto 0);

signal rdptr : unsigned(2 downto 0) := "000";
signal wrptr : unsigned(2 downto 0) := "000";

begin

process(clk)
begin
	if clk='1' and clk'Event then
		empty <= to_std_logic(rdptr = wrptr);	
		dout <= fifo_data(to_integer(rdptr));
		tido <= fifo_tiddata(to_integer(rdptr));
		fakeo <= fake_data(to_integer(rdptr));
		
		if rd='1' then
			rdptr <= rdptr + 1;
		end if;
		
		if wr='1' then
			fifo_data(to_integer(wrptr)) <= din;
			fifo_tiddata(to_integer(wrptr)) <= tidi;
			fake_data(to_integer(wrptr)) <= fakei;
			wrptr <= wrptr + 1;
		end if;
	end if;
end process;

end Behavioral;

