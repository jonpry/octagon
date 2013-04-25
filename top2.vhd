----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:28:50 04/23/2013 
-- Design Name: 
-- Module Name:    top2 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top2 is
end top2;

architecture Behavioral of top2 is

begin


end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:54 04/22/2013 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top2 is
	port  (
		clk : in std_logic;
		reset : in std_logic;
		pcout : out std_logic_vector(25 downto 0);
		jump_target : in std_logic_vector(25 downto 0);
		int : in std_logic;
		jump : in std_logic;
		running : in std_logic_vector(7 downto 0);
		valid : in std_logic;
		valid_o : out std_logic
	);
end top2;

architecture Behavioral of top2 is

signal count : std_logic_vector(2 downto 0) := "000";
signal countq : std_logic_vector(2 downto 0) := "000";
signal count2 : std_logic_vector(2 downto 0) := "000";
signal running_q : std_logic_vector(7 downto 0) := "00000000";


type pc_type is array(0 to 7) of std_logic_vector(25 downto 0);
signal pc : pc_type := (others => (others => '0'));
signal valid_od : std_logic := '0';

signal pcout_d : std_logic_vector(25 downto 0);
signal last_pc : std_logic_vector(25 downto 0);
signal cnt_valid : std_logic := '0';
signal do_jump : std_logic := '0';
signal running_edge : std_logic := '0';
signal running_e : std_logic := '0';

signal gndv : std_logic_vector(31 downto 0) := X"00000000";
begin

valid_o <= valid_od;
pcout <= pcout_d;

--toDO: modify jump target for interrupt and reset
process(clk)
begin
	if clk='1' and clk'Event then
		count2 <= std_logic_vector(unsigned(count) - 2);
		running_q(to_integer(unsigned(count2))) <= running(to_integer(unsigned(count2)));
		if running_q(to_integer(unsigned(count2))) = '0' and running(to_integer(unsigned(count2))) = '1' then
			running_edge <= '1';
		else
			running_edge <= '0';
		end if;
		running_e <= running(to_integer(unsigned(count2)));
		last_pc <= pc(to_integer(unsigned(count2)));
	end if;
end process;

process(clk)
variable this_pc : std_logic_vector(25 downto 0);
begin
	if clk='1' and clk'Event then
		countq <= count;

		if running_e = '0' then
			cnt_valid <= '0';
		else
			if running_edge = '1' then
				cnt_valid <= '1';
			else
				cnt_valid <= valid;
			end if;
		end if;

		count <= std_logic_vector(unsigned(count)+1);
		this_pc := last_pc;
		if jump = '1' and valid = '1' then
			this_pc := jump_target;
		else
			if valid = '1' then
				this_pc := std_logic_vector(unsigned(this_pc)+1);
			end if;
		end if;
		pcout_d <= this_pc;
	end if;
end process;

process(clk)
begin
	if clk = '1' and clk'Event then
			pc(to_integer(unsigned(countq))) <= pcout_d;
	end if;
end process;

end Behavioral;

