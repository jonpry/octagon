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
		
		aluout.cond <= aluin.cond;
	end if;
end process;

--Some alu funcs
process(clk)
	variable r_s_ext : std_logic_vector(32 downto 0);
	variable r_t_ext : std_logic_vector(32 downto 0);
	variable sum 	  : std_logic_vector(32 downto 0);
	variable diff 	  : std_logic_vector(32 downto 0);
	variable logic   : std_logic_vector(31 downto 0);
	variable sum_ovf : std_logic;
	variable diff_ovf: std_logic;
begin
	if clk='1' and clk'Event then
		r_s_ext := aluin.r_s(31) & aluin.r_s;
		r_t_ext := aluin.r_t(31) & aluin.r_t;
		
		--Adder
		sum := std_logic_vector(unsigned(r_s_ext) + unsigned(r_t_ext));
		sum_ovf := to_std_logic(sum(32) /= sum(31));
		
		--Subtractor
		diff := std_logic_vector(unsigned(r_s_ext) - unsigned(r_t_ext));
		diff_ovf := to_std_logic(diff(32) /= diff(31));
		
		--Logic
		case aluin.logicop is
				when logicop_and =>  logic := aluin.r_s and aluin.r_t;
				when logicop_or  =>  logic := aluin.r_s or aluin.r_t;
				when logicop_xor =>  logic := aluin.r_s xor aluin.r_t;
				when logicop_nor =>  logic := aluin.r_s nor aluin.r_t;
		end case;
		
		if aluin.add = '1' then
				aluout.arith_ovf <= sum_ovf;
		else
				aluout.arith_ovf <= diff_ovf;		
		end if;
		
		case aluin.alu2mux is
				when alu2mux_add   => aluout.mux <= sum(31 downto 0);
				when alu2mux_sub   => aluout.mux <= diff(31 downto 0);
				when alu2mux_lui   => aluout.mux <= aluin.r_t(15 downto 0) & X"0000";
				when alu2mux_logic => aluout.mux <= logic;
		end case;
		
		--Mux cases
		--add
		--subtract
		--pc (link)
		--logic
		--lui
		--special regs
		--slt
	end if;
end process;

--Comparisons
process(clk)
begin
	if clk='1' and clk'Event then
		aluout.eq <= to_std_logic(aluin.r_s = aluin.r_t);
		if aluin.comp_unsigned = '1' then
			aluout.lt <= to_std_logic(unsigned(aluin.r_s) < unsigned(aluin.r_t));				
		else
			aluout.lt <= to_std_logic(signed(aluin.r_s) < signed(aluin.r_t));
		end if;
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
		
		shiftone   := shift(16,aluin.shift_part,aluin.shift.op,aluin.shift.amount(4));
		shifttwo   := shift(8,shiftone,aluin.shift.op,aluin.shift.amount(3));
		shiftthree := shift(4,shifttwo,aluin.shift.op,aluin.shift.amount(2));

		aluout.shift_part <= shiftthree;
	end if;
	
end process;

end Behavioral;

