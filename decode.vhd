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
		
		--TODO: link instructions have r_dest = 31
	--Type R instructions
		if link = '1' then
			decout.r_dest <= "11111";
		elsif opzero = '1' then
			decout.r_dest <= muxout.instr(15 downto 11);
		else
			decout.r_dest <= muxout.instr(20 downto 16);
		end if;
		
		decout.r_s <= muxout.instr(25 downto 21);
		decout.r_t <= muxout.instr(20 downto 16);
		
	-- Decode RFE instruction (see @note3)
		decout.rfe <= to_std_logic(instr(31 downto 21)="01000010000" and func ="010000");

	--Load instructions
		decout.load <= to_std_logic(instr(31 downto 29)="100");
		
	-- Decode store operations
		decout.store <= to_std_logic(instr(31 downto 29)="101");

		decout.memsize <= instr(27 downto 26);
		decout.load_unsigned <= instr(28);    -- sign extend vs. zero extend

	--Add,Sub,Slt
		decout.arith <= to_std_logic(opcode(5 downto 1)="00100" or 
             (opzero='1' and func(5 downto 2)="1000"));
				  
	--Subtraction conditional stuff
		decout.slt <= to_std_logic( (opzero = '1' and func(5 downto 1)="10101") or
                        opcode(5 downto 1)="00101");
								
	--Logical operations
		decout.logic <= to_std_logic((opzero='1' and func(5 downto 2) ="1001") or
								instr(31 downto 28)="0011");
								
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
		decout.jump <= to_std_logic((opcode(5 downto 3) = "000" and opcode(2 downto 0) /= "000") or
							(opzero = '1' and func(5 downto 1) = "00100"));
		
	--This is for slt, add, sub. mul/div 
		decout.math_unsigned <= to_std_logic(func(0)='1' or opcode(0)='1');
	end if;
end process;

end Behavioral;

