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
		ints : in std_logic_vector(7 downto 0);
		dcout : in dcfetchout_type;
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
		jumpout.store_cop0 <= aluin.store_cop0;
		jumpout.store_hi <= aluin.store_hi;
		jumpout.store_lo <= aluin.store_lo;
		jumpout.rfe <= aluin.rfe;
	end if;
end process;

--if ints & ~imask /= 0
--		ipend <= ints &! imask
--		if dojump 
--			epc = pcjump
--		else
--			if ovf  --ovf should not store to register
--				epc = pc
--			else
--	  		   epc = pc + 4
--		cause <= int
--		exc <= '1'

--Jump processing
process(clk)
	variable jump_target : std_logic_vector(IM_BITS-1 downto 0);
	variable ipend : std_logic_vector(7 downto 0);
	variable valid : std_logic;
begin
	if clk='1' and clk'Event then
		jumpout.do_jump <= '1';	
		
		--TODO: owns only matters for memory operations
		valid := to_std_logic(aluin.valid = '1' and ((aluin.load='0' and aluin.store = '0') or dcout.owns /= X"00"));
		jumpout.valid <= valid;
		
		if valid = '0' then
			jump_target := aluin.pc;
		elsif aluin.rfe = '1' or (aluin.met = '1' and aluin.do_jump='1') then
			jump_target := aluin.pcjump;
		else
			jump_target := std_logic_vector(unsigned(aluin.pc) + 4);
 		end if;
		
		ipend := ints and (not aluin.imask);
		
		--TODO: handle ovf
		if ipend /= X"00" and valid = '1' then
			jumpout.jump_target <= (others => '0');
			jumpout.do_int <= '1';
		else
			jumpout.jump_target <= jump_target;
			jumpout.do_int <= '0';
		end if;
		
		jumpout.epc <= jump_target;
		jumpout.ipend <= ipend;
		
	end if;
end process;

--ALU operations running in this stage
process(clk)
	variable jmux : jmux_type;
	variable shift_part : std_logic_vector(31 downto 0);
begin
	if clk='1' and clk'Event then
		jumpout.slt <= aluin.met;
		
	-- Potentially add load to this mux
		case aluin.jmux is
			when jmux_arith	=> jumpout.mux <= aluin.arith;
			when jmux_spec		=> jumpout.mux <= aluin.spec;
			when jmux_mul		=> jumpout.mux <= aluin.mul;
			when jmux_rt		=> jumpout.mux <= aluin.r_t;
		end case;
	
	-- Final barrel shift stage
		shift_part := shift(1,aluin.shift_part,aluin.shift.op,aluin.shift.amount(0));
		jumpout.shiftout <= shift(2,shift_part,aluin.shift.op,aluin.shift.amount(1));
	end if;
end process;

end Behavioral;

