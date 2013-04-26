----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:38:04 04/23/2013 
-- Design Name: 
-- Module Name:    decode - Behavioral 
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

use work.octagon_types.all;
use work.octagon_funcs.all;

entity decode is
	Port ( 
		clk : in  std_logic;
		muxout : in icmuxout_type;
		decout : out decout_type
	);
end decode;

architecture Behavioral of decode is

begin

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
begin
	if clk='1' and clk'Event then
		decout.pc <= muxout.pc;
		decout.valid <= muxout.valid;
		decout.tid <= muxout.tid;
		
		opcode := muxout.instr(31 downto 26);
		instr := muxout.instr;
		func := muxout.instr(5 downto 0);
		opzero := to_std_logic(opcode="000000");
		
	--Link instructions
		link := to_std_logic((opzero='1' and func(5 downto 0)="001001") or
                    (opcode="000001" and instr(20)='1') or
                    (opcode="000011"));
		decout.link <= link;
		
		
		
	--link instructions have r_dest = 31
		if link = '1' then
			decout.r_dest <= "11111";
	--Type R instructions
		elsif opzero = '1' then
			decout.r_dest <= muxout.instr(15 downto 11);
		else
			decout.r_dest <= muxout.instr(20 downto 16);
		end if;
		
		decout.r_s <= muxout.instr(25 downto 21);
		
	--bltz and the like are comparizons against zero, so we force zero reg usage
		if opcode = "000001" then
			decout.r_t <= "00000";
		else
			decout.r_t <= muxout.instr(20 downto 16);
		end if;
		
	-- Decode RFE instruction 
		decout.rfe <= to_std_logic(instr(31 downto 21)="01000010000" and func ="010000");

	--Load instructions
		decout.load <= to_std_logic(instr(31 downto 29)="100");
		
	-- Decode store operations
		decout.store <= to_std_logic(instr(31 downto 29)="101");

		decout.memsize <= instr(27 downto 26);
		decout.load_unsigned <= instr(28);    -- sign extend vs. zero extend

	--Add,Sub
		add := to_std_logic(opcode(5 downto 1) = "00100" or
				(opzero='1' and func(5 downto 1) = "10000"));
		sub := to_std_logic(opzero='1' and func(5 downto 1) = "10001");

		decout.add <= add;
		
				  
	--Subtraction conditional stuff
		slt := to_std_logic( (opzero = '1' and func(5 downto 1)="10101") or
                        opcode(5 downto 1)="00101");
		decout.slt <= slt;
		decout.comp_unsigned <= to_std_logic( opcode = "001011" or 
						(opzero = '1' and func = "101011"));
		
	--Lui
		lui := to_std_logic(func = "001111");
								
	--Logical operations
		logic := to_std_logic((opzero='1' and func(5 downto 2) ="1001") or
								instr(31 downto 28)="0011");
		decout.logic <= logic;
		
	--Shift parameters
		decout.shift.amount <= instr(10 downto 6);
		decout.shift.reg <= func(2);
		shift_right := func(1);
		shift_arith := func(0);
		shift_do := to_std_logic(opzero='1' and func(5 downto 3) = "000");

		decout.shift.do <= shift_do;
		
		if shift_do = '0' then
			decout.shift.op <= shiftop_none;
		else
			if shift_right = '0' then
				decout.shift.op <= shiftop_left;
			else
				decout.shift.op <= shiftop_right;
			end if;
		end if;
		
	--Jump
		jumpi := to_std_logic(opcode(5 downto 3) = "000" and opcode(2 downto 0) /= "000");
		decout.jump <= to_std_logic(jumpi = '1' or (opzero = '1' and func(5 downto 1) = "00100"));
		
	--Long jumps
		decout.long_target <= instr(25 downto 0);
		decout.long_jump <= to_std_logic(opcode(5 downto 1) = "00001");
		
	--This is for slt, add, sub. mul/div 
		decout.math_unsigned <= to_std_logic((opzero = '1' and func(0)='1') or opcode(0)='1');
		
	--Immediate handling	
		decout.immediate(15 downto 0) <= instr(15 downto 0);
		if opcode(5 downto 2) = "0011" or instr(15)='0' then
			decout.immediate(31 downto 16) <= X"0000";
		else
			decout.immediate(31 downto 16) <= X"FFFF";
		end if;

	--Branch instructions do comparison on the 2 registers, so we prevent the mux into the alu
	--from operating. jump pc is calculate elseware anyways
		decout.use_immediate <= to_std_logic(opzero = '0' and jumpi = '0');
		
		if opzero = '1' then
			case func(1 downto 0) is
				when "00"  =>  decout.logicop <= logicop_and;
				when "01"  =>  decout.logicop <= logicop_or;
				when "10"  =>  decout.logicop <= logicop_xor;
				when "11"  =>  decout.logicop <= logicop_nor;
				when others => decout.logicop <= logicop_nor;
			end case;		
		else
			case opcode(1 downto 0) is
				when "00"  =>  decout.logicop <= logicop_and;
				when "01"  =>  decout.logicop <= logicop_or;
				when "10"  =>  decout.logicop <= logicop_xor;
				when "11"  =>  decout.logicop <= logicop_nor;
				when others => decout.logicop <= logicop_nor;
			end case;
		end if;
		
	--Priority encoder for alu2mux
		if add = '1' then
			decout.alu2mux <= alu2mux_add;
		else
			if add = '1' then
				decout.alu2mux <= alu2mux_sub;
			else 
				if lui = '1' then
					decout.alu2mux <= alu2mux_lui;
				else
					decout.alu2mux <= alu2mux_logic;
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
			decout.cond <= cond_lt;
		else
			if opcode = "000001" then
				decout.cond <= cond2;
			else
				decout.cond <= cond1;
			end if;
		end if;
		
	end if;
end process;

end Behavioral;

