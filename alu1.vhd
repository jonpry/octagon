----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:19:34 04/24/2013 
-- Design Name: 
-- Module Name:    alu1 - Behavioral 
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

entity alu1 is
	Port ( 
		clk : in  std_logic;
		aluin : in alu1in_type;
		aluout : out alu1out_type
	);
end alu1;

architecture Behavioral of alu1 is

type reg_type is array(0 to 7) of std_logic_vector(31 downto 0);
signal epc : reg_type := (others => (others => '0'));
signal hi : reg_type := (others => (others => '0'));
signal lo : reg_type := (others => (others => '0'));

type itype is array(0 to 7) of std_logic_vector(7 downto 0);
signal imask : itype := (others => (others => '0'));
signal ipend : itype := (others => (others => '0')); 

type etype is array(0 to 7) of std_logic_vector(3 downto 0);
signal ecode : etype := (others => (others => '0'));

signal exc : std_logic_vector(7 downto 0) := (others => '0');
signal int : std_logic_vector(7 downto 0) := (others => '0');

signal pproduct1 : std_logic_vector(65 downto 0);
signal pproduct2 : std_logic_vector(65 downto 0);
signal pproduct3 : std_logic_vector(65 downto 0);
signal pproduct4 : std_logic_vector(65 downto 0);
signal pproduct5 : std_logic_vector(65 downto 0);
signal pproduct6 : std_logic_vector(65 downto 0);
signal pproduct7 : std_logic_vector(65 downto 0);

signal lo_wrq : std_logic;
signal lo_wrqq : std_logic;
signal hi_wrq : std_logic;
signal hi_wrqq : std_logic;
signal mtmulq : std_logic;
signal mtmulqq : std_logic;
signal mulidxq : std_logic_vector(2 downto 0);
signal mulidxqq : std_logic_vector(2 downto 0);
signal lmuxq : std_logic_vector(31 downto 0);
signal lmuxqq : std_logic_vector(31 downto 0);

signal foo  : std_logic;
signal foo1 : std_logic;
signal foo2 : std_logic;
signal foo3 : std_logic;
signal foo4 : std_logic;
signal foo5 : std_logic;
signal foo6 : std_logic;
signal foo7 : std_logic;

signal r_s_ext_cond : std_logic_vector(32 downto 0);
signal r_t_ext_cond : std_logic_vector(32 downto 0);

begin

--It *was* very difficult to get anything done in this stage because of 
--poor timing with blockram output registers

--Control signals
process(clk)
	variable r_s_ext : std_logic_vector(32 downto 0);
	variable r_t_ext : std_logic_vector(32 downto 0);

	variable sum 	  : std_logic_vector(32 downto 0);
	variable diff 	  : std_logic_vector(32 downto 0);
	variable	r_t	  : std_logic_vector(31 downto 0);
	
	variable unaligned : unsigned(2 downto 0);
	variable is_aligned : std_logic;
begin
	if clk='1' and clk'Event then
		aluout.pc <= aluin.rfetch.pc;
		aluout.tid <= aluin.rfetch.tid;
		aluout.valid <= aluin.rfetch.valid;

		aluout.logicop <= aluin.rfetch.logicop;
		aluout.add <= aluin.rfetch.add;
		aluout.arithmux <= aluin.rfetch.arithmux;
		aluout.comp_unsigned <= aluin.rfetch.comp_unsigned;
		aluout.r_s <= aluin.rfetch.r_s;
		aluout.cond <= aluin.rfetch.cond;
		aluout.specmux <= aluin.rfetch.specmux;
		aluout.jmux <= aluin.rfetch.jmux;
		aluout.lmux <= aluin.rfetch.lmux;
		aluout.r_dest <= aluin.rfetch.r_dest;
		aluout.store_cond <= aluin.rfetch.store_cond;
		aluout.pcmux <= aluin.rfetch.pcmux;
		aluout.immediate <= aluin.rfetch.immediate;
		aluout.do_jump <= aluin.rfetch.do_jump;
		aluout.memsize <= aluin.rfetch.memsize;
		aluout.load_unsigned <= aluin.rfetch.load_unsigned;
		aluout.store_cop0 <= aluin.rfetch.store_cop0;
		aluout.mulmux <= aluin.rfetch.mulmux;
		aluout.store_hi <= aluin.rfetch.store_hi;
		aluout.store_lo <= aluin.rfetch.store_lo;
		aluout.rfe <= aluin.rfetch.rfe;
		aluout.use_immediate <= aluin.rfetch.use_immediate;
		aluout.cacheop <= aluin.rfetch.cacheop;
		aluout.dcache_op <= to_std_logic(aluin.rfetch.cache = '1' and aluin.rfetch.inotd = '0' and aluin.rfetch.valid = '1');
		aluout.cache_p <= aluin.rfetch.cache_p;
		aluout.mtmul <= aluin.rfetch.mtmul;
		aluout.ls_left <= aluin.rfetch.ls_left;
		aluout.ls_right <= aluin.rfetch.ls_right;
		aluout.invalid_op <= aluin.rfetch.invalid_op;

		aluout.wbr_complete <= aluin.wbrout.valid;
		aluout.wbr_data <= aluin.wbrout.data;
				
		if aluin.rfetch.use_immediate = '1' then
			r_t := aluin.rfetch.immediate;
		else
			r_t := aluin.rfetch.r_t;
		end if;
		aluout.r_t <= r_t;
		
	--Next PC
		aluout.pcadd <= std_logic_vector(unsigned(aluin.rfetch.pc(IM_BITS-1 downto 2)) + unsigned(aluin.rfetch.immediate(IM_BITS-3 downto 0)) + 1) & "00";
		
	--Calculate memory access address including unaligned left offset	
		unaligned := "000";
		if aluin.rfetch.ls_left = '1' then
			unaligned := "100";
		end if;
		aluout.memadr <= std_logic_vector(unsigned(aluin.rfetch.r_s(DM_BITS+1 downto 0)) + unsigned(aluin.rfetch.immediate(DM_BITS+1 downto 0)) + unaligned);

	--Short circuit unaligned left if already aligned
		is_aligned := to_std_logic(std_logic_vector(unsigned(aluin.rfetch.r_s(1 downto 0)) + unsigned(aluin.rfetch.immediate(1 downto 0))) = "00");
		aluout.load <= to_std_logic(aluin.rfetch.load='1' and (aluin.rfetch.ls_left = '0' or is_aligned='0'));
		aluout.store <= to_std_logic(aluin.rfetch.store='1' and (aluin.rfetch.ls_left = '0' or is_aligned='0'));
		aluout.reg_store <= to_std_logic(aluin.rfetch.reg_store='1' and (aluin.rfetch.load = '0' or aluin.rfetch.ls_left = '0' or is_aligned = '0'));

	--Sign extend
		r_s_ext := aluin.rfetch.r_s(31) & aluin.rfetch.r_s;
		r_t_ext := r_t(31) & r_t;
		
	--Multiplication stuff. We must do pipelining in this module or the synthesizer can't find it. 
		r_s_ext_cond <= to_std_logic(aluin.rfetch.r_s(31) = '1' and aluin.rfetch.math_unsigned = '0') & aluin.rfetch.r_s;
		r_t_ext_cond <= to_std_logic(aluin.rfetch.r_t(31) = '1' and aluin.rfetch.math_unsigned = '0') & aluin.rfetch.r_t;
		
		pproduct1 <= std_logic_vector(signed(r_s_ext_cond) * signed(r_t_ext_cond));
		pproduct2 <= pproduct1;
		pproduct3 <= pproduct2;
		pproduct4 <= pproduct3;
		pproduct5 <= pproduct4;
		pproduct6 <= pproduct5;
		pproduct7 <= pproduct6;
		
		foo <= aluin.rfetch.store_hi;
		foo1 <= foo;
		foo2 <= foo1;
		foo3 <= foo2;
		foo4 <= foo3;
		foo5 <= foo4;
		foo6 <= foo5;
		foo7 <= foo6;
		
	--Adder
		sum := std_logic_vector(unsigned(r_s_ext) + unsigned(r_t_ext));
		aluout.sum_ovf <= to_std_logic(sum(32) /= sum(31));
		aluout.sum <= sum(31 downto 0);
		
	--Subtractor
		diff := std_logic_vector(unsigned(r_s_ext) - unsigned(r_t_ext));
		aluout.diff_ovf <= to_std_logic(diff(32) /= diff(31));
		aluout.diff <= diff(31 downto 0);

	--Compare
		aluout.eq <= to_std_logic(aluin.rfetch.r_s = r_t);
		if aluin.rfetch.comp_unsigned = '1' then
			aluout.lt_reg <= to_std_logic(unsigned(aluin.rfetch.r_s) < unsigned(aluin.rfetch.r_t));
			aluout.lt_imm <= to_std_logic(unsigned(aluin.rfetch.r_s) < unsigned(aluin.rfetch.immediate));
		else
			aluout.lt_reg <= to_std_logic(signed(aluin.rfetch.r_s) < signed(aluin.rfetch.r_t));
			aluout.lt_imm <= to_std_logic(signed(aluin.rfetch.r_s) < signed(aluin.rfetch.immediate));
		end if;
	end if;
end process;

--First stage barrel shift
process(clk)
	variable shamt : std_logic_vector(4 downto 0);
	variable shiftop : shiftop_type;
begin
	if clk='1' and clk'Event then
		shamt := aluin.rfetch.shift.amount;
		if aluin.rfetch.shift.reg = '1' then
			shamt := aluin.rfetch.r_s(4 downto 0);
		end if;
		
		aluout.shift <= aluin.rfetch.shift;
		aluout.shift.amount <= shamt;
		
		shiftop := aluin.rfetch.shift.op;
		if shiftop = shiftop_right and aluin.rfetch.r_t(31) = '1' and aluin.rfetch.shift_arith = '1' then
			shiftop := shiftop_right_neg;
		end if;
		
		aluout.shift.op <= shiftop;
	end if;
end process;

--Fetch special registers
process(clk)
variable tididx : Integer;
variable wtididx : Integer;
variable mulidx : Integer;
begin
	if clk='1' and clk'Event then
		tididx := to_integer(unsigned(aluin.rfetch.tid));
		aluout.cop0.epc <= epc(tididx);
		aluout.cop0.ipend <= ipend(tididx);
		aluout.cop0.imask <= imask(tididx);
		aluout.cop0.ecode <= ecode(tididx);
		aluout.cop0.int <= int(tididx);
		aluout.cop0.exc <= exc(tididx);
		
		wtididx := to_integer(unsigned(aluin.rout.cop0_tid));		
		if aluin.rout.epc_wr = '1' then
			epc(wtididx) <= aluin.rout.cop0.epc;
		end if;
		
		if aluin.rout.int_wr = '1' then
			imask(wtididx) <= aluin.rout.cop0.imask;
			int(wtididx) <= aluin.rout.cop0.int;
		end if;

		if aluin.rout.exc_wr = '1' then
			exc(wtididx) <= aluin.rout.cop0.exc;
		end if;
		
		if aluin.rout.cause_wr = '1' then
			ipend(wtididx) <= aluin.rout.cop0.ipend;		
			ecode(wtididx) <= aluin.rout.cop0.ecode;
		end if;
		
		--Multiplier writes are delayed by 2 cycles
		hi_wrq <= aluin.rout.hi_wr;
		hi_wrqq <= hi_wrq;
		lo_wrq <= aluin.rout.lo_wr;
		lo_wrqq <= lo_wrq;
		mtmulq <= aluin.rout.mtmul;
		mtmulqq <= mtmulq;
		mulidxq <= aluin.rout.cop0_tid;		
		mulidxqq <= mulidxq;
		lmuxq <= aluin.rout.lmux;
		lmuxqq <= lmuxq;
		mulidx := to_integer(unsigned(mulidxqq));
		
		if hi_wrqq = '1' then
			if mtmulqq = '1' then
				aluout.hi <= lmuxqq;
			else
				aluout.hi <= pproduct7(63 downto 32);
			end if;
		else
			aluout.hi <= hi(tididx);
		end if;
		
		if lo_wrqq = '1' then
			if mtmulqq = '1' then
				aluout.lo <= lmuxqq;
			else
				aluout.lo <= pproduct7(31 downto 0);
			end if;
		else
			aluout.lo <= lo(tididx);
		end if;
					
		if hi_wrqq = '1' then
			if mtmulqq = '1' then
				hi(mulidx) <= lmuxqq;
			else
				hi(mulidx) <= pproduct7(63 downto 32);
			end if;
		end if;
		
		if lo_wrqq = '1' then
			if mtmulqq = '1' then
				lo(mulidx) <= lmuxqq;
			else
				lo(mulidx) <= pproduct7(31 downto 0);
			end if;
		end if;
		
	end if;
end process;


end Behavioral;

