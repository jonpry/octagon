----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:00:53 04/24/2013 
-- Design Name: 
-- Module Name:    alu2 - Behavioral 
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

entity alu2 is
	Port ( 
		clk : in  std_logic;
		aluin : in alu1out_type;
		aluout : out alu2out_type
	);
end alu2;

architecture Behavioral of alu2 is

begin

--Control signals
process(clk)
begin
	if clk='1' and clk'Event then
		aluout.pc <= aluin.pc;
		aluout.tid <= aluin.tid;
		aluout.valid <= aluin.valid;
		aluout.jmux <= aluin.jmux;
		aluout.lmux <= aluin.lmux;
		aluout.r_dest <= aluin.r_dest;
		aluout.reg_store <= aluin.reg_store;
		aluout.store_cond <= aluin.store_cond;
		aluout.do_jump <= aluin.do_jump;
		aluout.load <= aluin.load;
		aluout.store <= aluin.store;
		aluout.memadr <= aluin.memadr(1 downto 0);
		aluout.dcwradr <= aluin.memadr(9 downto 0);
		aluout.memsize <= aluin.memsize;
		aluout.load_unsigned <= aluin.load_unsigned;
		aluout.store_cop0 <= aluin.store_cop0;
		aluout.r_t <= aluin.r_t;
		aluout.store_hi <= aluin.store_hi;
		aluout.store_lo <= aluin.store_lo;
		aluout.rfe <= aluin.rfe;
	end if;
end process;

--Some alu funcs
process(clk)
	variable logic   : std_logic_vector(31 downto 0);
	variable	be		  : std_logic_vector(3 downto 0);
begin
	if clk='1' and clk'Event then
		
		--Logic
		case aluin.logicop is
				when logicop_and =>  logic := aluin.r_s and aluin.r_t;
				when logicop_or  =>  logic := aluin.r_s or aluin.r_t;
				when logicop_xor =>  logic := aluin.r_s xor aluin.r_t;
				when logicop_nor =>  logic := aluin.r_s nor aluin.r_t;
		end case;
		
		if aluin.add = '1' then
				aluout.arith_ovf <= aluin.sum_ovf;
		else
				aluout.arith_ovf <= aluin.diff_ovf;		
		end if;
		
		case aluin.arithmux is
				when arithmux_add   => aluout.arith <= aluin.sum;
				when arithmux_sub   => aluout.arith <= aluin.diff;
				when arithmux_lui   => aluout.arith <= aluin.r_t(15 downto 0) & X"0000";
				when arithmux_logic => aluout.arith <= logic;
		end case;
		
	--Mux for special registers	
		case aluin.specmux is
				when specmux_pc		=> aluout.spec <= (31 downto IM_BITS => '0') & std_logic_vector(unsigned(aluin.pc)+4);
				when specmux_epc 		=> aluout.spec <= aluin.cop0.epc;
				when specmux_status	=> aluout.spec <= (31 downto 19 => '0') & aluin.tid & aluin.cop0.imask & "000000" & aluin.cop0.exc & aluin.cop0.int;
				when specmux_cause	=> aluout.spec <= (31 downto 16 => '0') & aluin.cop0.ipend & "00" & aluin.cop0.ecode & "00";
		end case;
		
	--Mux for multiplier
		case aluin.mulmux is
				when mulmux_hi		=> aluout.mul <= aluin.hi;
				when mulmux_lo		=> aluout.mul <= aluin.lo;
		end case;
		
	--PC Mux
		case aluin.pcmux is
				when pcmux_imm16	=> aluout.pcjump <= aluin.pcadd;
				when pcmux_reg		=> aluout.pcjump <= aluin.r_s(IM_BITS-1 downto 0);
				--TODO: this is not compatible with changing IM_BITS
				when pcmux_imm26	=> aluout.pcjump <= aluin.immediate(23 downto 0) & "00";
				when pcmux_rfe 	=> aluout.pcjump <= aluin.cop0.epc(IM_BITS-1 downto 0);
		end case;
		
	--shifter for stores goes in this stage
		aluout.store_data(7 downto 0) <= aluin.r_t(7 downto 0);
		if aluin.memadr(1 downto 0) = "01" then
			aluout.store_data(15 downto 8) <= aluin.r_t(7 downto 0);
		else
			aluout.store_data(15 downto 8) <= aluin.r_t(15 downto 8);
		end if;
	
		if aluin.memadr(1 downto 0) = "10" then
			aluout.store_data(23 downto 16) <= aluin.r_t(7 downto 0);
		else
			aluout.store_data(23 downto 16) <= aluin.r_t(23 downto 16);
		end if;
	
		if aluin.memadr(1 downto 0) = "11" then
			aluout.store_data(31 downto 24) <= aluin.r_t(7 downto 0);
		else
			if aluin.memadr(1 downto 0) = "10" then
				aluout.store_data(31 downto 24) <= aluin.r_t(15 downto 8);
			else
				aluout.store_data(31 downto 24) <= aluin.r_t(31 downto 24);
			end if;
		end if;
	--generate the byte enables	
		case aluin.memsize is
			when "00"	=> be := "0001";	
			when "01"	=> be := "0011";
			when others => be := "1111";
		end case;
		
		case aluin.memadr(1 downto 0) is
			when "00"	=> aluout.be <= be;
			when "01"	=> aluout.be <= be(2 downto 0) & "0";
			when "10"	=> aluout.be <= be(1 downto 0) & "00";
			when others => aluout.be <= be(0) & "000";
		end case;
		
		aluout.dcwren <= aluin.valid and aluin.store;
		
	end if;
end process;

--Handle interrupt enables
process(clk)
begin
	if clk='1' and clk'Event then
		if aluin.cop0.int = '1' and aluin.cop0.exc = '0' then
			aluout.imask <= aluin.cop0.imask;
		else
			aluout.imask <= X"FF";
		end if;
	end if;
end process;

--Comparisons
process(clk)
	variable met : std_logic;
	variable lt : std_logic;
begin
	if clk='1' and clk'Event then
	--Figure out if condition was met
		if aluin.use_immediate = '1' then
			lt := aluin.lt_imm;
		else
			lt := aluin.lt_reg;
		end if;
		case aluin.cond is
			when cond_none => met := '1';
			when cond_eq   => met := aluin.eq;
			when cond_lt   => met := lt;
			when cond_gt   => met := to_std_logic(lt = '0' and aluin.eq = '0');
			when cond_lte  => met := to_std_logic(lt = '1' or aluin.eq = '1');
			when cond_gte  => met := to_std_logic(lt = '0' or aluin.eq = '1');
			when cond_neq  => met := to_std_logic(aluin.eq = '0');
		end case;
		aluout.met <= met;
	end if;
end process;

--Barrel shift stage
process(clk)
	variable shiftone : std_logic_vector(31 downto 0);
	variable shifttwo : std_logic_vector(31 downto 0);
	variable shiftthree : std_logic_vector(31 downto 0);
begin
	if clk='1' and clk'Event then
		aluout.shift <= aluin.shift;
				
		shiftone   := shift(16,aluin.r_t,aluin.shift.op,aluin.shift.amount(4));
		shifttwo   := shift(8,shiftone,aluin.shift.op,aluin.shift.amount(3));
		shiftthree := shift(4,shifttwo,aluin.shift.op,aluin.shift.amount(2));

		aluout.shift_part <= shiftthree;
	end if;
	
end process;

end Behavioral;

