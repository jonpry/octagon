----------------------------------------------------------------------------------
-- Company: Pry Mfg Co
-- Engineer: Jon Pry
-- 
-- Create Date:    23:52:35 04/24/2013 
-- Design Name: 
-- Module Name:    jump - Behavioral 
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

entity jump is
	Port ( 
		clk : in std_logic;
		aluin : in alu2out_type;
		jumpout : out jumpout_type
	);
end jump;

architecture Behavioral of jump is

signal shiftout : std_logic_vector(31 downto 0);

begin

process(clk)
begin
	if clk='1' and clk'Event then
		jumpout.tid <= aluin.tid;
		jumpout.valid <= aluin.valid;
		jumpout.pc <= aluin.pc;
		jumpout.lmux <= aluin.lmux;
		jumpout.r_dest <= aluin.r_dest;
		jumpout.reg_store <= aluin.reg_store;
		jumpout.store_cond <= aluin.store_cond;
		jumpout.met <= aluin.met;
		jumpout.load <= aluin.load;
		jumpout.memadr <= aluin.memadr;
		jumpout.memsize <= aluin.memsize;
		jumpout.load_unsigned <= aluin.load_unsigned;
	end if;
end process;

--Jump processing
process(clk)
begin
	if clk='1' and clk'Event then
		jumpout.jump_target <= aluin.pcjump;
		if aluin.met = '1' and aluin.do_jump='1' then
			jumpout.do_jump <= '1';
		else
			jumpout.do_jump <= '0';
		end if;
	end if;
end process;

--ALU operations running in this stage
process(clk)
	variable jmux : jmux_type;
	variable shift_part : std_logic_vector(31 downto 0);
begin
	if clk='1' and clk'Event then
		if aluin.met = '1' then
			jumpout.slt <= (31 downto 1 => '0') & "1";
		else
			jumpout.slt <= (31 downto 0 => '0');
		end if;

	-- Potentially add load to this mux
		case aluin.jmux is
			when jmux_arith	=> jumpout.mux <= aluin.arith;
			when jmux_spec		=> jumpout.mux <= aluin.spec;
		end case;
	
	-- Final barrel shift stage
		shift_part := shift(1,aluin.shift_part,aluin.shift.op,aluin.shift.amount(0));
		jumpout.shiftout <= shift(2,shift_part,aluin.shift.op,aluin.shift.amount(1));
	end if;
end process;

end Behavioral;

