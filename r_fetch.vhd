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
use work.octagon_funcs.all;

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

signal r_t : std_logic_vector(31 downto 0);
signal r_s : std_logic_vector(31 downto 0);
signal r_tq : std_logic_vector(31 downto 0);
signal r_sq : std_logic_vector(31 downto 0);

--Prevent absorbtion of output register stage
attribute keep : string;  
attribute keep of r_tq: signal is "true";  
attribute keep of r_sq: signal is "true";  

begin

rout.r_s <= r_sq;
rout.r_t <= r_tq;

process(clk)
	variable adr  : std_logic_vector(7 downto 0);
	variable adr2 : std_logic_vector(7 downto 0);
begin
	if clk='1' and clk'Event then
		rout.pc <= rin.decout.pc;
		rout.tid <= rin.decout.tid;
		rout.valid <= rin.decout.valid;
		
		adr := rin.decout.ftid & rin.decout.r_s;
		adr2 := rin.decout.ftid & rin.decout.r_t;
		r_s <= regram1(to_integer(unsigned(adr)));
		r_t <= regram2(to_integer(unsigned(adr2)));
		
		r_sq <= r_s;
		r_tq <= r_t;
		
		if rin.reg_we = '1' then
			regram1(to_integer(unsigned(rin.reg_adr))) <= rin.reg_val;
			regram2(to_integer(unsigned(rin.reg_adr))) <= rin.reg_val;		
		end if;
	end if;
end process;


process(clk)
	variable opcode : std_logic_vector(5 downto 0);
	variable func : std_logic_vector(5 downto 0);
	variable instr : std_logic_vector(31 downto 0);
	variable opzero : std_logic;
	variable link	: std_logic;
	variable shift_right : std_logic;
	variable shift_arith : std_logic;
	variable shift_do : std_logic;
	variable add : std_logic;
	variable sub : std_logic;
	variable lui : std_logic;
	variable logic : std_logic;
	variable jumpi : std_logic;
	variable slt: std_logic;
	variable cond1 : cond_type;
	variable cond2 : cond_type;
	variable arith : std_logic;
	variable reg_store : std_logic;
	variable load : std_logic;
	variable store : std_logic;
	variable cop0 : std_logic;
	variable copreg : std_logic_vector(4 downto 0);
	variable mtc0 : std_logic;
	variable mmul : std_logic;
	variable mtmul : std_logic;
	variable rfe : std_logic;
begin
	if clk='1' and clk'Event then
		opcode := rin.decout.instr(31 downto 26);
		instr := rin.decout.instr;
		func := rin.decout.instr(5 downto 0);
		opzero := to_std_logic(opcode="000000");
		
	--Link instructions
		link := to_std_logic((opzero='1' and func(5 downto 0)="001001") or
                    (opcode="000001" and instr(20)='1') or
                    (opcode="000011"));
		
	-- Coprocessor stuff
		cop0 := to_std_logic(opcode = "010000");
		copreg := instr(15 downto 11);
		mtc0 := to_std_logic(cop0 = '1' and instr(25 downto 21) = "00100");
		rout.store_cop0 <= mtc0;
		
	--Multiplier
		mmul := to_std_logic(opzero='1' and func(5 downto 2) = "0100");
		mtmul := to_std_logic(mmul = '1' and func(0) = '1');
		rout.store_hi <= to_std_logic(mmul = '1' and func(1 downto 0) = "01");
		rout.store_lo <= to_std_logic(mmul = '1' and func(1 downto 0) = "11" );
		
	--link instructions have r_dest = 31
		if link = '1' then
			rout.r_dest <= "11111";
	--Type R instructions
		elsif opzero = '1' or mtc0 = '1' then
			rout.r_dest <= instr(15 downto 11);
		else
			rout.r_dest <= instr(20 downto 16);
		end if;
		
	-- Decode RFE instruction 
		rfe := to_std_logic(instr(31 downto 21)="01000010000" and func ="010000");
		rout.rfe <= rfe;
		
	--Load instructions
		load := to_std_logic(instr(31 downto 29)="100");
		rout.load <= load;
		
	-- Decode store operations
		store := to_std_logic(instr(31 downto 29)="101");
		rout.store <= store;
		
		rout.memsize <= instr(27 downto 26);
		rout.load_unsigned <= instr(28);    -- sign extend vs. zero extend

	--Add,Sub
		add := to_std_logic(opcode(5 downto 1) = "00100" or
				(opzero='1' and func(5 downto 1) = "10000"));
		sub := to_std_logic(opzero='1' and func(5 downto 1) = "10001");

		rout.add <= add;
		
	--Arith
		arith := to_std_logic(opcode(5 downto 3) = "001" or 
				(opzero='1' and func(5 downto 3) = "100"));
				  
	--Subtraction conditional stuff
		slt := to_std_logic( (opzero = '1' and func(5 downto 1)="10101") or
                        opcode(5 downto 1)="00101");
		rout.comp_unsigned <= to_std_logic( opcode = "001011" or 
						(opzero = '1' and func = "101011"));
		
	--Lui
		lui := to_std_logic(opcode = "001111");
								
	--Logical operations
		logic := to_std_logic((opzero='1' and func(5 downto 2) ="1001") or
								instr(31 downto 28)="0011");
--		rout.logic <= logic;
		
	--Shift parameters
		rout.shift.amount <= instr(10 downto 6);
		rout.shift.reg <= func(2);
		shift_right := func(1);
		shift_arith := func(0);
		shift_do := to_std_logic(opzero='1' and func(5 downto 3) = "000");

		rout.shift.do <= shift_do;
		
		if shift_do = '0' then
			rout.shift.op <= shiftop_none;
		else
			if shift_right = '0' then
				rout.shift.op <= shiftop_left;
			else
				rout.shift.op <= shiftop_right;
			end if;
		end if;
		
	--Jump
		jumpi := to_std_logic(opcode(5 downto 3) = "000" and opcode(2 downto 0) /= "000");
		rout.do_jump <= to_std_logic(jumpi = '1' or (opzero = '1' and func(5 downto 1) = "00100"));
		
	--Long jumps
--		rout.long_target <= instr(25 downto 0);
--		rout.long_jump <= to_std_logic(opcode(5 downto 1) = "00001");
		
	--This is for slt, add, sub. mul/div 
--		rout.math_unsigned <= to_std_logic((opzero = '1' and func(0)='1') or opcode(0)='1');

		reg_store := to_std_logic(load='1' or arith='1' or shift_do='1' or
					opcode(5 downto 0) = "000011" or --jal
					(opzero='1' and func(5 downto 0) = "001001") or --jalr
					(cop0='1' and instr(25 downto 21) = "00000") or --mfc0
					(opzero='1' and func(5 downto 2) = "0100" and func(0) = '0')); --mfmul
		rout.reg_store <= reg_store;
		rout.store_cond <= to_std_logic(slt = '1' or 
					(link='1' and reg_store='0'));
		
	--Immediate handling	
		rout.immediate(15 downto 0) <= instr(15 downto 0);
		if opcode(5 downto 2) = "0011" or instr(15)='0' then
			rout.immediate(31 downto 16) <= X"0000";
		else
			rout.immediate(31 downto 16) <= X"FFFF";
		end if;

	--Branch instructions do comparison on the 2 registers, so we prevent the mux into the alu
	--from operating. jump pc is calculate elseware anyways
	--Stores use r_t for data in spite of having immediates
	--cop0 is register only
		rout.use_immediate <= to_std_logic(opzero = '0' and jumpi = '0' and 
							store = '0' and cop0 = '0' and mmul = '0');
		
		if opzero = '1' then
			case func(1 downto 0) is
				when "00"  =>  rout.logicop <= logicop_and;
				when "01"  =>  rout.logicop <= logicop_or;
				when "10"  =>  rout.logicop <= logicop_xor;
				when "11"  =>  rout.logicop <= logicop_nor;
				when others => rout.logicop <= logicop_nor;
			end case;		
		else
			case opcode(1 downto 0) is
				when "00"  =>  rout.logicop <= logicop_and;
				when "01"  =>  rout.logicop <= logicop_or;
				when "10"  =>  rout.logicop <= logicop_xor;
				when "11"  =>  rout.logicop <= logicop_nor;
				when others => rout.logicop <= logicop_nor;
			end case;
		end if;
		
	--Priority encode for mulmux
		if func(1) = '1' then
			rout.mulmux <= mulmux_lo;
		else
			rout.mulmux <= mulmux_hi;
		end if;
	
		
	--Priority encoder for pcmux
		if opcode(5 downto 1) = "00001" then
			rout.pcmux <= pcmux_imm26;
		else
			if jumpi = '1' then
				rout.pcmux <= pcmux_imm16;
			else
				if rfe = '1' then
					rout.pcmux <= pcmux_rfe;
				else
					rout.pcmux <= pcmux_reg;
				end if;
			end if;
		end if;
		
	--Priority encoder for lmux
		if slt = '1' then
			rout.lmux <= lmux_slt;
		else
			if shift_do = '1' then
				rout.lmux <= lmux_shift;
			else
				rout.lmux <= lmux_jmux;
			end if;
		end if;
		
	--Priority encoder for jmux
		if arith = '1' or mtmul='1' then
			rout.jmux <= jmux_arith;
		else
			if mtc0='1' then
				rout.jmux <= jmux_rt;
			else
				if mmul='1' then
					rout.jmux <= jmux_mul;
				else
					rout.jmux <= jmux_spec;
				end if;
			end if;
		end if;
		
	--Priority encoder for special mux
		if link = '1' then
			rout.specmux <= specmux_pc;
		else
			if copreg = "01100" then
				rout.specmux <= specmux_status;
			else
				if copreg = "01101" then
					rout.specmux <= specmux_cause;
				else
					rout.specmux <= specmux_epc;
				end if;
			end if;
		end if;
		
	--Priority encoder for alu2mux
		if add = '1' then
			rout.arithmux <= arithmux_add;
		else
			if add = '1' then
				rout.arithmux <= arithmux_sub;
			else 
				if lui = '1' then
					rout.arithmux <= arithmux_lui;
				else
					rout.arithmux <= arithmux_logic;
				end if;
			end if;
		end if;
		
	--Find condition code
		case opcode(2 downto 0) is
				when "100"  => cond1 := cond_eq;
				when "101"  => cond1 := cond_neq;
				when "110"  => cond1 := cond_lte;
				when "111"  => cond1 := cond_gt;
				when others => cond1 := cond_none;
		end case;
		
		if instr(16) = '1' then
			cond2 := cond_gte;
		else
			cond2 := cond_lt;
		end if;
		
		if slt = '1' then
			rout.cond <= cond_lt;
		else
			if opzero = '1' and func(5 downto 1) = "00100" then
				rout.cond <= cond_none;
			else
				if opcode = "000001" then
					rout.cond <= cond2;
				else
					rout.cond <= cond1;
				end if;
			end if;
		end if;
		
	end if;
end process;

end Behavioral;

