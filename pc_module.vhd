----------------------------------------------------------------------------------
-- Company: Pry Mfg Co
-- Engineer: Jon Pry
-- 
-- Create Date:    11:58:54 04/22/2013 
-- Design Name: 
-- Module Name:    pc_module - Behavioral 
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

entity pc_module is
	port  (
		clk : in std_logic;
		pcin : in pcin_type;
		pcout : out pcout_type
	);
end pc_module;

architecture Behavioral of pc_module is

--Ram to store PC's
type pc_type is array(0 to 7) of std_logic_vector(IM_BITS-1 downto 0);
signal pc : pc_type := (others => (others => '0'));
signal valid_od : std_logic := '0';

signal count : unsigned(2 downto 0) := "000";
signal countq : unsigned(2 downto 0) := "000";
signal count2 : unsigned(2 downto 0) := "000";
signal running_q : std_logic_vector(7 downto 0) := "00000000";

signal pc_add : std_logic_vector(IM_BITS-1 downto 0);
signal pc_jump : std_logic_vector(IM_BITS-1 downto 0);
signal pc_next : std_logic_vector(IM_BITS-1 downto 0);
signal target : std_logic_vector(IM_BITS-1 downto 0);
signal running_edge : std_logic := '0';
signal enabled : std_logic := '0';
signal go_to_reset : std_logic;
signal valid : std_logic;
signal restart : std_logic;

signal gndv : std_logic_vector(31 downto 0) := X"00000000";
begin

pcout.tid <= std_logic_vector(countq);

--toDO: modify jump target for interrupt 
--Pre stage, operates at T-1 to setup values for main PC code
count2 <= count + 1;
process(clk)
	variable restartV : std_logic;
begin
	if clk='1' and clk'Event then
		restartV := pcin.restarts(to_integer(count2));
		pcout.restarted(to_integer(count2)) <= restartV;
		restart <= restartV;
		
		running_q(to_integer(count2)) <= pcin.running(to_integer(count2));
		go_to_reset <= '0';
		if running_q(to_integer(count2)) = '0' and pcin.running(to_integer(count2)) = '1' then
			running_edge <= '1';
			go_to_reset <= '1';
		else
			running_edge <= '0';
		end if;
		enabled <= pcin.running(to_integer(count2));
	end if;
end process;

valid <= '1' when (pcin.valid = '1' or restart='1' or running_edge='1') and enabled = '1' else '0';
target <= pcin.jump_target when pcin.valid = '1' else pcin.pc;

pc_next <= (others => '0') when enabled = '0' or running_edge = '1' or pcin.do_int = '1' else target;

pcout.pc_next <= pc_next;

--Main Stage, calculate new PC
process(clk)
begin
	if clk='1' and clk'Event then
		countq <= count;

		count <= count2;
		pcout.valid <= valid;
		pcout.pc <= pc_next;
	end if;
end process;

end Behavioral;

