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

entity top is
	port  (
		clk : in std_logic;
		reset : in std_logic;
		pcout : out std_logic_vector(25 downto 0);
		pcin : in std_logic_vector(25 downto 0);
		tago : out std_logic_vector(12 downto 0);
		int : in std_logic;
		jump : in std_logic;
		running : in std_logic_vector(7 downto 0);
		valid : in std_logic;
		valid_o : out std_logic
	);
end top;

architecture Behavioral of top is

COMPONENT TagRam
  PORT (
    a : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    dpra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;
    dpo : OUT STD_LOGIC_VECTOR(12 DOWNTO 0)
  );
END COMPONENT;

signal count : std_logic_vector(2 downto 0) := "000";
signal countq : std_logic_vector(2 downto 0) := "000";
signal running_q : std_logic_vector(7 downto 0) := "00000000";

signal tago1 : std_logic_vector(12 downto 0);
signal tago2 : std_logic_vector(12 downto 0);
signal tago3 : std_logic_vector(12 downto 0);
signal tago4 : std_logic_vector(12 downto 0);
signal tago5 : std_logic_vector(12 downto 0);
signal tago6 : std_logic_vector(12 downto 0);
signal tago7 : std_logic_vector(12 downto 0);
signal tago8 : std_logic_vector(12 downto 0);

type pc_type is array(0 to 7) of std_logic_vector(25 downto 0);
signal pc : pc_type := (others => (others => '0'));
signal valid_od : std_logic := '0';

signal jump_pc : std_logic_vector(25 downto 0);
signal add_pc : std_logic_vector(25 downto 0);
signal pcout_d : std_logic_vector(25 downto 0);
signal cnt_valid : std_logic := '0';
signal do_jump : std_logic := '0';

signal gndv : std_logic_vector(31 downto 0) := X"00000000";
begin

valid_o <= valid_od;
pcout <= pcout_d;

process(clk)
variable this_pc : std_logic_vector(25 downto 0);
variable running_edge : std_logic;
begin
	if clk='1' and clk'Event then
		countq <= count;
		running_q(to_integer(unsigned(count))) <= running(to_integer(unsigned(count)));
		if running_q(to_integer(unsigned(count))) = '0' and running(to_integer(unsigned(count))) = '1' then
			running_edge := '1';
		else
			running_edge := '0';
		end if;
		if running(to_integer(unsigned(count))) = '0' then
			cnt_valid <= '0';
		else
			if running_edge = '1' then
				cnt_valid <= '1';
			else
				cnt_valid <= valid;
			end if;
		end if;

		count <= std_logic_vector(unsigned(count)+1);
		this_pc := pc(to_integer(unsigned(count)));
		if int = '1' or running_edge = '1' then
			jump_pc <= "00000000000000000000000000";
		else
			jump_pc <= pcin;
		end if;
		if int = '1' or running_edge = '1' or jump = '1' then
			do_jump <= '1';
		else
			do_jump <= '0';
		end if;
		add_pc <= std_logic_vector(unsigned(this_pc)+1);
	end if;
end process;

process(clk)
variable this_pc : std_logic_vector(25 downto 0);
begin
	if clk='1' and clk'Event then
		valid_od <= cnt_valid;
		if cnt_valid = '1' then
			if do_jump = '1' then
				this_pc := jump_pc;
			else
				this_pc := add_pc;
			end if;
			pc(to_integer(unsigned(countq))) <= std_logic_vector(unsigned(this_pc));
			pcout_d <= this_pc;
		end if;
	end if;
end process;

Tag1 : TagRam
  PORT MAP (
    a => gndv(6 downto 0),
    d => gndv(12 downto 0),
    dpra => pcout_d(12 downto 6),
    clk => clk,
    we => gndv(0),
    dpo => tago1
  );
Tag2 : TagRam
  PORT MAP (
    a => gndv(6 downto 0),
    d => gndv(12 downto 0),
    dpra => pcout_d(12 downto 6),
    clk => clk,
    we => gndv(0),
    dpo => tago2
  );
Tag3 : TagRam
  PORT MAP (
    a => gndv(6 downto 0),
    d => gndv(12 downto 0),
    dpra => pcout_d(12 downto 6),
    clk => clk,
    we => gndv(0),
    dpo => tago3
  );
Tag4 : TagRam
  PORT MAP (
    a => gndv(6 downto 0),
    d => gndv(12 downto 0),
    dpra => pcout_d(12 downto 6),
    clk => clk,
    we => gndv(0),
    dpo => tago4
  );
Tag5 : TagRam
  PORT MAP (
    a => gndv(6 downto 0),
    d => gndv(12 downto 0),
    dpra => pcout_d(12 downto 6),
    clk => clk,
    we => gndv(0),
    dpo => tago5
  );
Tag6 : TagRam
  PORT MAP (
    a => gndv(6 downto 0),
    d => gndv(12 downto 0),
    dpra => pcout_d(12 downto 6),
    clk => clk,
    we => gndv(0),
    dpo => tago6
  );
Tag7 : TagRam
  PORT MAP (
    a => gndv(6 downto 0),
    d => gndv(12 downto 0),
    dpra => pcout_d(12 downto 6),
    clk => clk,
    we => gndv(0),
    dpo => tago7
  );
  Tag8 : TagRam
  PORT MAP (
    a => gndv(6 downto 0),
    d => gndv(12 downto 0),
    dpra => pcout_d(12 downto 6),
    clk => clk,
    we => gndv(0),
    dpo => tago8
  );

tago <= tago1 or tago2 or tago3 or tago4 or tago5 or tago6 or tago7 or tago8;

end Behavioral;

