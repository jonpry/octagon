----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:42 04/24/2013 
-- Design Name: 
-- Module Name:    r_fetch - Behavioral 
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

entity r_fetch is
	Port ( 
		clk : in  std_logic;
		rin : in rfetchin_type;
		rout : out rfetchout_type
	);
end r_fetch;

architecture Behavioral of r_fetch is

type regtype is array(0 to 255) of std_logic_vector(31 downto 0);
signal regram1 : regtype := (others => (others => '0'));
signal regram2 : regtype := (others => (others => '0'));

begin

process(clk)
	variable adr  : std_logic_vector(7 downto 0);
	variable adr2 : std_logic_vector(7 downto 0);
begin
	if clk='1' and clk'Event then
		rout.pc <= rin.decout.pc;
		rout.tid <= rin.decout.tid;
		rout.valid <= rin.decout.valid;
		
		rout.shift <= rin.decout.shift;
		rout.immediate <= rin.decout.immediate;
		rout.use_immediate <= rin.decout.use_immediate;
		rout.logicop <= rin.decout.logicop;
		rout.add <= rin.decout.add;
		rout.alu2mux <= rin.decout.alu2mux;
		rout.comp_unsigned <= rin.decout.comp_unsigned;
		rout.cond <= rin.decout.cond;
		
		adr := rin.decout.tid & rin.decout.r_s;
		adr2 := rin.decout.tid & rin.decout.r_t;
		rout.r_s <= regram1(to_integer(unsigned(adr)));
		rout.r_t <= regram2(to_integer(unsigned(adr2)));
		
		if rin.reg_we = '1' then
			regram1(to_integer(unsigned(rin.reg_adr))) <= rin.reg_val;
			regram2(to_integer(unsigned(rin.reg_adr))) <= rin.reg_val;		
		end if;
	end if;
end process;

end Behavioral;

