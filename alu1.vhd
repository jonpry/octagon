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

type epc_type is array(0 to 7) of std_logic_vector(31 downto 0);
signal epc : epc_type := (others => (others => '0'));

type itype is array(0 to 7) of std_logic_vector(7 downto 0);
signal imask : itype := (others => (others => '0'));
signal ipend : itype := (others => (others => '0')); 

type etype is array(0 to 7) of std_logic_vector(3 downto 0);
signal ecode : etype := (others => (others => '0'));

signal exc : std_logic_vector(7 downto 0) := (others => '0');
signal int : std_logic_vector(7 downto 0) := (others => '0');

begin

--It is very difficult to get anything done in this stage because of 
--poor timing with blockram output registers

--Control signals
process(clk)
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
		aluout.reg_store <= aluin.rfetch.reg_store;
		aluout.store_cond <= aluin.rfetch.store_cond;
		aluout.pcmux <= aluin.rfetch.pcmux;
		aluout.immediate <= aluin.rfetch.immediate;
		aluout.do_jump <= aluin.rfetch.do_jump;
		aluout.load <= aluin.rfetch.load;
		aluout.memsize <= aluin.rfetch.memsize;
		aluout.load_unsigned <= aluin.rfetch.load_unsigned;
		aluout.store <= aluin.rfetch.store;
		
		if aluin.rfetch.use_immediate = '1' then
			aluout.r_t <= aluin.rfetch.immediate;
		else
			aluout.r_t <= aluin.rfetch.r_t;
		end if;
		
		aluout.pcadd <= std_logic_vector(unsigned(aluin.rfetch.pc(IM_BITS-1 downto 2)) + unsigned(aluin.rfetch.immediate(IM_BITS-3 downto 0))) & "00";
		aluout.memadr <= std_logic_vector(unsigned(aluin.rfetch.r_s(DM_BITS+1 downto 0)) + unsigned(aluin.rfetch.immediate(DM_BITS+1 downto 0)));
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
		if shiftop = shiftop_right and aluin.rfetch.r_t(31) = '1' then
			shiftop := shiftop_right_neg;
		end if;
		
		aluout.shift.op <= shiftop;
	end if;
end process;

--Fetch special registers
process(clk)
variable tididx : Integer;
variable wtididx : Integer;
begin
	if clk='1' and clk'Event then
		tididx := to_integer(unsigned(aluin.rfetch.tid));
		aluout.cop0.epc <= epc(tididx);
		aluout.cop0.ipend <= ipend(tididx);
		aluout.cop0.imask <= imask(tididx);
		aluout.cop0.ecode <= ecode(tididx);
		aluout.cop0.int <= int(tididx);
		aluout.cop0.exc <= int(tididx);
		
		if aluin.cop0_wr = '1' then
			wtididx := to_integer(unsigned(aluin.cop0_tid));
			epc(wtididx) <= aluin.cop0.epc;
			ipend(wtididx) <= aluin.cop0.ipend;
			imask(wtididx) <= aluin.cop0.imask;
			ecode(wtididx) <= aluin.cop0.ecode;
			int(wtididx) <= aluin.cop0.int;
			exc(wtididx) <= aluin.cop0.exc;
		end if;
	end if;
end process;


end Behavioral;

