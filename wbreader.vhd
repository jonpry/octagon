----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:22:00 04/26/2013 
-- Design Name: 
-- Module Name:    dc_mem - Behavioral 
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

entity wbreader is
	Port ( 
		clk : in  std_logic;
		wbrin : in wbrin_type;
		decout : in decout_type;
		wbrout : out wbrout_type
	);
end wbreader;

architecture Behavioral of wbreader is

type dat_type is array (0 to 7) of std_logic_vector(31 downto 0);

signal data : dat_type := (others => (others => '0'));
signal valid : std_logic_vector(7 downto 0) := X"00"; 

attribute ram_style: string;
attribute ram_style of valid : signal is "distributed";

signal restarts : std_logic_vector(7 downto 0) := X"00";

begin

wbrout.restarts <= restarts;

process(clk)
begin
	if clk='1' and clk'Event then
		restarts <= restarts and not wbrin.restarted;

		if decout.valid = '1' then
			wbrout.valid <= valid(to_integer(unsigned(decout.tid)));
			valid(to_integer(unsigned(decout.tid))) <= '0';
			wbrout.data <= data(to_integer(unsigned(decout.tid)));
		end if;

		if wbrin.valid = '1' then
			data(to_integer(unsigned(wbrin.tid))) <= wbrin.dat;
			valid(to_integer(unsigned(wbrin.tid))) <= '1';
			restarts(to_integer(unsigned(wbrin.tid))) <= '1';	
		end if;
	end if;
end process;

end Behavioral;

