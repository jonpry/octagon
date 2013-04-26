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
		rout : in rfetchout_type;
		aluout : out alu1out_type
	);
end alu1;

architecture Behavioral of alu1 is

begin

--It is very difficult to get anything done in this stage because of 
--poor timing with blockram output registers

--Control signals
process(clk)
begin
	if clk='1' and clk'Event then
		aluout.pc <= rout.pc;
		aluout.tid <= rout.tid;
		aluout.valid <= rout.valid;

		aluout.logicop <= rout.logicop;
		aluout.add <= rout.add;
		aluout.arithmux <= rout.arithmux;
		aluout.comp_unsigned <= rout.comp_unsigned;
		aluout.r_s <= rout.r_s;
		aluout.cond <= rout.cond;
		aluout.specmux <= rout.specmux;
		aluout.jmux <= rout.jmux;
		aluout.smux <= rout.smux;
		aluout.r_dest <= rout.r_dest;
		aluout.reg_store <= rout.reg_store;
		aluout.store_cond <= rout.store_cond;
		aluout.pcmux <= rout.pcmux;
		aluout.immediate <= rout.immediate;
		aluout.do_jump <= rout.do_jump;
		
		if rout.use_immediate = '1' then
			aluout.r_t <= rout.immediate;
		else
			aluout.r_t <= rout.r_t;
		end if;
		
		aluout.pcadd <= std_logic_vector(unsigned(rout.pc) + unsigned(rout.immediate(IM_BITS-1 downto 0)));
		aluout.memadr <= std_logic_vector(unsigned(rout.r_s(DM_BITS-1 downto 0)) + unsigned(rout.immediate(DM_BITS-1 downto 0)));
	end if;
end process;

--First stage barrel shift
process(clk)
	variable shamt : std_logic_vector(4 downto 0);
	variable shiftop : shiftop_type;
begin
	if clk='1' and clk'Event then
		shamt := rout.shift.amount;
		if rout.shift.reg = '1' then
			shamt := rout.r_s(4 downto 0);
		end if;
		
		aluout.shift <= rout.shift;
		aluout.shift.amount <= shamt;
		
		shiftop := rout.shift.op;
		if shiftop = shiftop_right and rout.r_t(31) = '1' then
			shiftop := shiftop_right_neg;
		end if;
		
		aluout.shift.op <= shiftop;
	end if;
end process;


end Behavioral;

