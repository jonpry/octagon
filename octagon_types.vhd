----------------------------------------------------------------------------------
-- Company: Pry Mfg Co
-- Engineer: Jon Pry
-- 
-- Create Date:    15:52:50 04/23/2013 
-- Design Name: 
-- Module Name:    octagon_types - Behavioral 
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


package octagon_types is
	 	 	 
	constant DM_BITS : integer := 26;
	constant IM_BITS : integer := 26;

	type tag_type is array(0 to 15) of std_logic_vector(IM_BITS-1 downto 10);
	type iout_type is array(0 to 7) of std_logic_vector(31 downto 0);
	type shiftop_type is (shiftop_none, shiftop_left, shiftop_right, shiftop_right_neg);
	type logicop_type is (logicop_and, logicop_or, logicop_xor, logicop_nor);
	type alu2mux_type is (alu2mux_add, alu2mux_sub, alu2mux_lui, alu2mux_logic);
	type cond_type is (cond_none, cond_eq, cond_lt, cond_gt, cond_lte, cond_gte, cond_neq);

	
	type pcin_type is record
		jump_target 	: std_logic_vector(IM_BITS-1 downto 0);
		running 			: std_logic_vector(7 downto 0);
		int 				: std_logic_vector(7 downto 0);
		jump 				: std_logic;
		valid 			: std_logic;
	end record;
	
	type pcout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		valid				: std_logic;
		tid				: std_logic_vector(2 downto 0);
	end record;
	
	type icfetchin_type is record
		pcout				: pcout_type;
		tagidx			: std_logic_vector(2 downto 0);
		tagadr			: std_logic_vector(3 downto 0);
		tagval			: std_logic_vector(IM_BITS-1 downto 10);
		tagwe				: std_logic;
		imemidx			: std_logic_vector(2 downto 0);
		imemadr			: std_logic_vector(7 downto 0);
		imemval			: std_logic_vector(31 downto 0);
		imemwe			: std_logic;
	end record;
	
	type icfetchout_type is record
		owns				: std_logic_vector(7 downto 0);
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		instr				: iout_type;
	end record;
	
	type icmuxout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		instr				: std_logic_vector(31 downto 0);
	end record;
	
	type shift_type is record
		reg		: std_logic;
		do			: std_logic;
		amount	: std_logic_vector(4 downto 0);
		op			: shiftop_type;
	end record;
	
	type decout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		r_dest			: std_logic_vector(4 downto 0);
		r_s				: std_logic_vector(4 downto 0);
		r_t				: std_logic_vector(4 downto 0);
		link				: std_logic;
		rfe 				: std_logic;
		load				: std_logic;
		store				: std_logic;
		memsize			: std_logic_vector(1 downto 0);
		load_unsigned 	: std_logic;
		slt				: std_logic;
		logic				: std_logic;
		shift				: shift_type;
		jump				: std_logic;
		math_unsigned	: std_logic;
		immediate		: std_logic_vector(31 downto 0);
		long_jump		: std_logic;
		long_target		: std_logic_vector(25 downto 0);
		use_immediate	: std_logic;
		logicop			: logicop_type;
		add				: std_logic;
		alu2mux			: alu2mux_type;
		comp_unsigned  : std_logic;
		cond				: cond_type;
	end record;
	
	type rfetchin_type is record
		decout			: decout_type;
		reg_we			: std_logic;
		reg_adr			: std_logic_vector(7 downto 0);
		reg_val			: std_logic_vector(31 downto 0);
	end record;
	
	type rfetchout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		r_s				: std_logic_vector(31 downto 0);
		r_t				: std_logic_vector(31 downto 0);
		immediate		: std_logic_vector(31 downto 0);
		use_immediate	: std_logic;
		shift				: shift_type;
		logicop			: logicop_type;
		add				: std_logic;
		alu2mux			: alu2mux_type;
		comp_unsigned  : std_logic;
		cond				: cond_type;
	end record;
	
	type alu1out_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;	
		shift_part		: std_logic_vector(31 downto 0);
		shift				: shift_type;
		r_s				: std_logic_vector(31 downto 0);
		r_t				: std_logic_vector(31 downto 0);
		logicop			: logicop_type;
		add				: std_logic;
		alu2mux			: alu2mux_type;
		comp_unsigned	: std_logic;
		cond				: cond_type;
	end record;
	
	type alu2out_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;	
		shift_part		: std_logic_vector(31 downto 0);
		shift				: shift_type;
		mux				: std_logic_vector(31 downto 0);
		arith_ovf		: std_logic;
		met				: std_logic;
	end record;
	
	type jumpout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;	
		met				: std_logic;
		--Just for notrim
		shiftout			: std_logic_vector(31 downto 0);
	end record;
	
end package;


