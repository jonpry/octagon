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
	 	 	 
	constant DM_BITS : integer := 32;
	constant IM_BITS : integer := 32;

	type tag_type is array(0 to 15) of std_logic_vector(IM_BITS-1+4 downto 10); --Extra 4 for ASID 
	type ptag_type is array(0 to 15) of std_logic_vector(IM_BITS-1 downto 12);
	type ptago_type is array(0 to 7) of std_logic_vector(IM_BITS-1 downto 12);
	type iout_type is array(0 to 7) of std_logic_vector(31 downto 0);
	type dout_type is array(0 to 3) of std_logic_vector(31 downto 0);
	type shiftop_type is (shiftop_none, shiftop_left, shiftop_right, shiftop_right_neg);
	type logicop_type is (logicop_and, logicop_or, logicop_xor, logicop_nor);
	type arithmux_type is (arithmux_add, arithmux_sub, arithmux_lui, arithmux_logic);
	type cond_type is (cond_none, cond_eq, cond_lt, cond_gt, cond_lte, cond_gte, cond_neq);
	type specmux_type is (specmux_pc, specmux_epc, specmux_cause, specmux_status, specmux_badva);
	type mulmux_type is (mulmux_hi, mulmux_lo, mulmux_rs);
	type jmux_type is (jmux_arith, jmux_spec, jmux_mul, jmux_rt);
	type lmux_type is (lmux_shift, lmux_slt, lmux_jmux);
	type pcmux_type is (pcmux_reg, pcmux_imm26, pcmux_imm16, pcmux_rfe);
	type cacheop_type is (cacheop_inv, cacheop_clean, cacheop_cinv, cacheop_unk);
	
	type tlbout_type is record
		hit				: std_logic;
		iack				: std_logic;
		dack				: std_logic;
		perm 				: std_logic_vector(2 downto 0);
		phys 				: std_logic_vector(IM_BITS-1 downto 12);
	end record;

	type tlbin_type is record
		dvaddr 			: std_logic_vector(IM_BITS-1 downto 0);
		ivaddr 			: std_logic_vector(IM_BITS-1 downto 0);
		dreq				: std_logic;
		ireq				: std_logic;
		dwnr				: std_logic;
		dtid				: std_logic_vector(2 downto 0);
		itid				: std_logic_vector(2 downto 0);
		dasid				: std_logic_vector(3 downto 0);
		iasid				: std_logic_vector(3 downto 0);
		
		perm 				: std_logic_vector(2 downto 0);
		asid 				: std_logic_vector(3 downto 0);
		phys 				: std_logic_vector(IM_BITS-1 downto 12);
		virt 				: std_logic_vector(IM_BITS-1 downto 12);
		size				: std_logic;
		wren 				: std_logic;
		wridx 			: std_logic_vector(1 downto 0);
		wradr 			: std_logic_vector(4 downto 0);
	end record;
	
	type tlbfetchin_type is record
		vpage 			: std_logic_vector(IM_BITS-1 downto 12);
		vasid 			: std_logic_vector(3 downto 0);

		perm 				: std_logic_vector(2 downto 0);
		asid 				: std_logic_vector(3 downto 0);
		phys 				: std_logic_vector(IM_BITS-1 downto 12);
		virt 				: std_logic_vector(IM_BITS-1 downto 12);
		size				: std_logic;
		wren 				: std_logic;
		wridx 			: std_logic_vector(1 downto 0);
		wradr 			: std_logic_vector(4 downto 0);
	end record;
	
	type tlbfetchout_type is record
		owns 				: std_logic;
		perm 				: std_logic_vector(2 downto 0);
		asid 				: std_logic_vector(3 downto 0);
		phys 				: std_logic_vector(IM_BITS-1 downto 12);
	end record;
	
	type cop0_type is record
		epc				: std_logic_vector(31 downto 0);
		imask				: std_logic_vector(7 downto 0);
		ipend				: std_logic_vector(7 downto 0);
		badva				: std_logic_vector(31 downto 0);
		exc				: std_logic;
		int				: std_logic;
		tlb				: std_logic;
		ksu				: std_logic;
		asid				: std_logic_vector(3 downto 0);
		ecode				: std_logic_vector(3 downto 0);
	end record;
	
	type rstoreout_type is record
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		r_dest			: std_logic_vector(4 downto 0);
		smux				: std_logic_vector(31 downto 0);
		be					: std_logic_vector(3 downto 0);
		cop0				: cop0_type;
		epc_wr			: std_logic;
		cause_wr			: std_logic;
		exc_wr			: std_logic;
		int_wr			: std_logic;
		cop0_tid			: std_logic_vector(2 downto 0);
		lmux				: std_logic_vector(31 downto 0);
		hi_wr				: std_logic;
		lo_wr				: std_logic;
		mtmul				: std_logic;
		entrylo			: std_logic_vector(31 downto 0);
		entryhi			: std_logic_vector(31 downto 0);
		tlbidx			: std_logic_vector(31 downto 0);
	end record;
	
	type pcin_type is record
		jump_target 	: std_logic_vector(IM_BITS-1 downto 0);
		pc				 	: std_logic_vector(IM_BITS-1 downto 0);
		running 			: std_logic_vector(7 downto 0);
		int 				: std_logic_vector(7 downto 0);
		do_int			: std_logic;
		jump 				: std_logic;
		cvalid 			: std_logic;
		abort				: std_logic;
		lnc				: std_logic;
		nc					: std_logic;
		restarts			: std_logic_vector(7 downto 0);
		rfe				: std_logic;
		invalid_op		: std_logic;
		rout				: rstoreout_type;
	end record;
	
	type pcout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		pc_next			: std_logic_vector(IM_BITS-1 downto 0);
		valid				: std_logic;
		abort				: std_logic;
		tid				: std_logic_vector(2 downto 0);
		asid				: std_logic_vector(3 downto 0);
		restarted		: std_logic_vector(7 downto 0);
		tlb				: std_logic;
		exc				: std_logic;
		ksu				: std_logic;
		sv					: std_logic;
	end record;
	
	type icfetchin_type is record
		pcout				: pcout_type;
		tagidx			: std_logic_vector(2 downto 0);
		tagadr			: std_logic_vector(3 downto 0);
		tagval			: std_logic_vector(IM_BITS-1+4 downto 10); --ASID
		ptagval			: std_logic_vector(IM_BITS-1 downto 12);
		sv					: std_logic;
		tagwe				: std_logic;
		imemidx			: std_logic_vector(2 downto 0);
		imemadr			: std_logic_vector(7 downto 0);
		imemval			: std_logic_vector(31 downto 0);
		imemwe			: std_logic;
	end record;
	
	type dcfetchin_type is record
		tid				: std_logic_vector(2 downto 0);
		asid				: std_logic_vector(3 downto 0);
		sv					: std_logic;
		adr				: std_logic_vector(DM_BITS-1 downto 0);
		tagidx			: std_logic_vector(2 downto 0);
		tagadr			: std_logic_vector(3 downto 0);
		tagval			: std_logic_vector(IM_BITS-1+4 downto 10);
		tagsv				: std_logic;
		ptagval			: std_logic_vector(IM_BITS-1 downto 12);
		tagwe				: std_logic;
		cacheop			: cacheop_type;
		dcache_op		: std_logic;
		cache_p			: std_logic;
		mntn_restart	: std_logic;
		mntn_tid			: std_logic_vector(2 downto 0);
	end record;
	
	type icfetchout_type is record
		owns				: std_logic_vector(7 downto 0);
		ownst				: std_logic_vector(7 downto 0);
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		instr				: iout_type;
		asid				: std_logic_vector(3 downto 0);
		tlb				: std_logic;
		ksu				: std_logic;
		exc				: std_logic;
		sv					: std_logic;
		ptag				: ptago_type;
	end record;
	
	type dcfetchout_type is record
		owns				: std_logic_vector(7 downto 0);
		ownst				: std_logic_vector(7 downto 0);
		phys				: std_logic_vector(7 downto 0);
		sel				: std_logic_vector(2 downto 0);
--		miss				: std_logic;
--		nc					: std_logic;
		adr				: std_logic_vector(DM_BITS-1 downto 0);
		tag				: std_logic_vector(DM_BITS-1+4 downto 10); --ASID
		ptag				: ptago_type;
		tagdemux			: tag_type;
		cacheop			: cacheop_type;
		dcache_op		: std_logic;
		cache_p			: std_logic;
	end record;
	
	type dcmemout_type is record
		data				: dout_type;
		sel				: std_logic_vector(1 downto 0);
		dmiss				: std_logic;
		tid				: std_logic_vector(2 downto 0);
		asid				: std_logic_vector(3 downto 0);
		tagm				: std_logic_vector(IM_BITS-1+4 downto 10);
		ptag				: std_logic_vector(IM_BITS-1 downto 12);
		adr				: std_logic_vector(DM_BITS-1 downto 0);
		dirty				: std_logic_vector(3 downto 0);
		ctl_data			: dout_type;
		cacheop			: cacheop_type;
		do_op				: std_logic;
		dcache_op		: std_logic;
		ll				   : std_logic;
	end record;
	
	type icmuxout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		instr				: std_logic_vector(31 downto 0);
		ptag			   : std_logic_vector(IM_BITS-1 downto 12);
		asid				: std_logic_vector(3 downto 0);
		tlb				: std_logic;
		exc				: std_logic;
		ksu				: std_logic;
		sv					: std_logic;
		imiss				: std_logic;
	end record;
	
	type dcmuxout_type is record
		data				: std_logic_vector(31 downto 0);
		slt				: std_logic;
		mux				: std_logic_vector(31 downto 0);
		shiftout			: std_logic_vector(31 downto 0);
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		lmux				: lmux_type;
		r_dest			: std_logic_vector(4 downto 0);
		reg_store		: std_logic;
		store_cond		: std_logic;
		met				: std_logic;
		memsize			: std_logic_vector(1 downto 0);
		memadr			: std_logic_vector(1 downto 0);
		load_unsigned 	: std_logic;
		load				: std_logic;
		ls_left			: std_logic;
		ls_right			: std_logic;
		store_cop0		: std_logic;
		do_int			: std_logic;
		invalid_op		: std_logic;
		epc				: std_logic_vector(IM_BITS-1 downto 0);
		ipend				: std_logic_vector(7 downto 0);
		store_hi			: std_logic;
		store_lo			: std_logic;
		rfe				: std_logic;
		wbr_complete 	: std_logic;
		wbr_data			: std_logic_vector(31 downto 0);
		mtmul				: std_logic;
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
		ftid				: std_logic_vector(2 downto 0);
		asid				: std_logic_vector(3 downto 0);
		tlb				: std_logic;
		ksu				: std_logic;
		exc				: std_logic;
		valid				: std_logic;
		r_s				: std_logic_vector(4 downto 0);
		r_t				: std_logic_vector(4 downto 0);
		instr				: std_logic_vector(31 downto 0);
		r_tz				: std_logic;
	end record;
	
	type rfetchin_type is record
		decout			: decout_type;
		reg_we			: std_logic;
		reg_be			: std_logic_vector(3 downto 0);
		reg_adr			: std_logic_vector(7 downto 0);
		reg_val			: std_logic_vector(31 downto 0);
	end record;
	
	type rfetchout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		asid				: std_logic_vector(3 downto 0);
		valid				: std_logic;
		r_s				: std_logic_vector(31 downto 0);
		r_t				: std_logic_vector(31 downto 0);
		immediate		: std_logic_vector(31 downto 0);
		r_dest			: std_logic_vector(4 downto 0);
		use_immediate	: std_logic;
		shift				: shift_type;
		shift_arith		: std_logic;
		logicop			: logicop_type;
		add				: std_logic;
		arithmux			: arithmux_type;
		comp_unsigned  : std_logic;
		cond				: cond_type;
		specmux			: specmux_type;
		jmux				: jmux_type;
		lmux				: lmux_type;
		reg_store		: std_logic;
		store_cond		: std_logic;
		pcmux				: pcmux_type;
		do_jump			: std_logic;
		load				: std_logic;
		ls_left			: std_logic;
		ls_right			: std_logic;
		memsize			: std_logic_vector(1 downto 0);
		load_unsigned	: std_logic;
		math_unsigned	: std_logic;
		store				: std_logic;
		store_cop0		: std_logic;
		mulmux			: mulmux_type;
		store_hi			: std_logic;
		store_lo			: std_logic;
		rfe				: std_logic;
		tlbwi				: std_logic;
		cache				: std_logic;
		inotd				: std_logic;
		cacheop			: cacheop_type;
		cache_p			: std_logic;
		mtmul				: std_logic;
		invalid_op		: std_logic;
		tlb				: std_logic;
		exc				: std_logic;
		ksu				: std_logic;
		sc				   : std_logic; --mips store-conditional operation
		ll					: std_logic;
	end record;
		
	type alu1out_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		asid				: std_logic_vector(3 downto 0);
		valid				: std_logic;	
		shift				: shift_type;
		r_s				: std_logic_vector(31 downto 0);
		r_t				: std_logic_vector(31 downto 0);
		immediate		: std_logic_vector(31 downto 0);
		memadr			: std_logic_vector(DM_BITS-1 downto 0);
		r_dest			: std_logic_vector(4 downto 0);
		logicop			: logicop_type;
		add				: std_logic;
		arithmux			: arithmux_type;
		comp_unsigned	: std_logic;
		cond				: cond_type;
		specmux			: specmux_type;
		jmux				: jmux_type;
		lmux				: lmux_type;
		reg_store		: std_logic;
		store_cond		: std_logic;
		pcmux				: pcmux_type;
		pcadd				: std_logic_vector(IM_BITS-1 downto 0);
		do_jump			: std_logic;
		load				: std_logic;
		ls_left			: std_logic;
		ls_right			: std_logic;
		memsize			: std_logic_vector(1 downto 0);
		load_unsigned	: std_logic;
		store				: std_logic;
		cop0				: cop0_type;
		sum				: std_logic_vector(31 downto 0);
		diff				: std_logic_vector(31 downto 0);
		sum_ovf			: std_logic;
		diff_ovf			: std_logic;
		store_cop0		: std_logic;
		hi					: std_logic_vector(31 downto 0);
		lo					: std_logic_vector(31 downto 0);
		mulmux			: mulmux_type;
		store_hi			: std_logic;
		store_lo			: std_logic;
		eq					: std_logic;
		lt_reg			: std_logic;
		lt_imm			: std_logic;
		rfe				: std_logic;
		use_immediate	: std_logic;
		wbr_complete 	: std_logic;
		wbr_data			: std_logic_vector(31 downto 0);
		cacheop			: cacheop_type;
		dcache_op		: std_logic;
		cache_p			: std_logic;
		mtmul				: std_logic;
		invalid_op		: std_logic;
		ll					: std_logic;
		tlb				: std_logic;
	end record;
	
	type alu2out_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		pcjump			: std_logic_vector(IM_BITS-1 downto 0);
		tid				: std_logic_vector(2 downto 0);
		asid				: std_logic_vector(3 downto 0);
		valid				: std_logic;	
		shift_part		: std_logic_vector(31 downto 0);
		shift				: shift_type;
		arith				: std_logic_vector(31 downto 0);
		spec				: std_logic_vector(31 downto 0);
		r_dest			: std_logic_vector(4 downto 0);
		arith_ovf		: std_logic;
		met				: std_logic;
		jmux				: jmux_type;
		lmux				: lmux_type;
		reg_store		: std_logic;
		store_cond		: std_logic;
		do_jump			: std_logic;
		load				: std_logic;
		store				: std_logic;
		ls_left			: std_logic;
		ls_right			: std_logic;
		memadr			: std_logic_vector(1 downto 0);
		memsize			: std_logic_vector(1 downto 0);
		load_unsigned	: std_logic;
		store_data		: std_logic_vector(31 downto 0);
		be					: std_logic_vector(3 downto 0);
		dcwren			: std_logic;
		dcrden			: std_logic;
		dcop				: std_logic;
		dcwradr			: std_logic_vector(DM_BITS-1 downto 0);
		store_cop0		: std_logic;
		imask				: std_logic_vector(7 downto 0);
		mul				: std_logic_vector(31 downto 0);
		r_t				: std_logic_vector(31 downto 0);
		store_hi			: std_logic;
		store_lo			: std_logic;
		rfe				: std_logic;
		wbr_complete 	: std_logic;
		wbr_data			: std_logic_vector(31 downto 0);
		memop				: std_logic;
		lnc				: std_logic;
		dcache_op		: std_logic;
		mtmul				: std_logic;
		invalid_op		: std_logic;
		ll				   : std_logic;
	end record;
	
	type wbmoutsig_type is record
		req				: std_logic;
		adr				: std_logic_vector(DM_BITS-1 downto 0);
		data				: std_logic_vector(31 downto 0);
		wren				: std_logic;	
	end record;
	
	type wbrin_type is record
		tid				: std_logic_vector(2 downto 0);
		dat				: std_logic_vector(31 downto 0);
		valid				: std_logic;
		restarted		: std_logic_vector(7 downto 0);
	end record;
	
	type wbrout_type is record
		restarts 		: std_logic_vector(7 downto 0);
		valid				: std_logic;
		data				: std_logic_vector(31 downto 0);
	end record;
	
	type wbmout_type is record
		sigs				: wbmoutsig_type;
		wbrin				: wbrin_type;
		nc					: std_logic;
		stall				: std_logic;
		restarts			: std_logic_vector(7 downto 0);
	end record;
	
	type wbmin_type is record
		cyc				: std_logic;
		ack				: std_logic;
		dat				: std_logic_vector(31 downto 0);
		restarted 		: std_logic_vector(7 downto 0);
	end record;
		
	type jumpout_type is record
		pc					: std_logic_vector(IM_BITS-1 downto 0);
		jump_target		: std_logic_vector(IM_BITS-1 downto 0);
		do_jump			: std_logic;
		tid				: std_logic_vector(2 downto 0);
		cvalid			: std_logic;	
		abort				: std_logic;
		lnc				: std_logic;
		met				: std_logic;
		mux				: std_logic_vector(31 downto 0);
		shiftout			: std_logic_vector(31 downto 0);
		slt				: std_logic;
		lmux				: lmux_type;
		r_dest			: std_logic_vector(4 downto 0);
		reg_store		: std_logic;
		store_cond		: std_logic;
		load				: std_logic;
		ls_left			: std_logic;
		ls_right			: std_logic;
		memadr			: std_logic_vector(1 downto 0);
		memsize			: std_logic_vector(1 downto 0);
		load_unsigned	: std_logic;
		store_cop0		: std_logic;
		do_int			: std_logic;
		invalid_op		: std_logic;
		epc				: std_logic_vector(IM_BITS-1 downto 0);
		ipend				: std_logic_vector(7 downto 0);
		store_hi			: std_logic;
		store_lo			: std_logic;
		rfe				: std_logic;
		wbr_complete 	: std_logic;
		wbr_data			: std_logic_vector(31 downto 0);
		mtmul				: std_logic;
	end record;
	
	type lmuxout_type is record
		tid				: std_logic_vector(2 downto 0);
		valid				: std_logic;
		r_dest			: std_logic_vector(4 downto 0);
		lmux				: std_logic_vector(31 downto 0);
		loadv				: std_logic_vector(31 downto 0);
		load				: std_logic;
		store_cop0		: std_logic;
		do_int			: std_logic;
		invalid_op		: std_logic;
		epc				: std_logic_vector(IM_BITS-1 downto 0);
		ipend				: std_logic_vector(7 downto 0);
		store_hi			: std_logic;
		store_lo			: std_logic;
		rfe				: std_logic;
		wbr_complete 	: std_logic;
		wbr_data			: std_logic_vector(31 downto 0);
		mtmul				: std_logic;
		be					: std_logic_vector(3 downto 0);
	end record;
	
	type dcmemin_type is record
		dmemidx			: std_logic_vector(2 downto 0);
		dmemadr			: std_logic_vector(7 downto 0);
		dmemval			: std_logic_vector(31 downto 0);
		dmemwe			: std_logic;
		dclean			: std_logic;
		dcout				: dcfetchout_type;
		alu2out			: alu2out_type;
	end record;
	
	type alu1in_type is record
		rfetch			: rfetchout_type;
		rout				: rstoreout_type;
		wbrout			: wbrout_type;
	end record;
	
	type ictlout_type is record
		memadr			: std_logic_vector(9 downto 0);
		memwe				: std_logic;
		tagadr			: std_logic_vector(IM_BITS-1+4 downto 6); --ASID
		tag_wr			: std_logic;
		tagidx			: std_logic_vector(2 downto 0);
		sv					: std_logic;
		mcb_en			: std_logic;
		mcb_cmd			: std_logic_vector(2 downto 0);
		mcb_bl			: std_logic_vector(5 downto 0);
		mcb_adr			: std_logic_vector(29 downto 0);
		mcb_rden			: std_logic;
		data				: std_logic_vector(31 downto 0);
		restarts			: std_logic_vector(7 downto 0);
	end record;
	
	type ictlin_type is record
		mcb_data			: std_logic_vector(31 downto 0);
		mcb_empty		: std_logic;
		mcb_cmd_full	: std_logic;
		restarted		: std_logic_vector(7 downto 0);
		ownst				: std_logic_vector(7 downto 0);
	end record;
	
	
	type dctlout_type is record
		memadr			: std_logic_vector(9 downto 0);
		memwe				: std_logic;
		tagadr			: std_logic_vector(IM_BITS-1+4 downto 6); --ASID
		tag_wr			: std_logic;
		tagidx			: std_logic_vector(2 downto 0);
		sv					: std_logic;
		mcb_en			: std_logic;
		mcb_cmd			: std_logic_vector(2 downto 0);
		mcb_bl			: std_logic_vector(5 downto 0);
		mcb_adr			: std_logic_vector(29 downto 0);
		mcb_rden			: std_logic;
		mcb_wren			: std_logic;
		data				: std_logic_vector(31 downto 0);
		restarts			: std_logic_vector(7 downto 0);
		mcb_data			: std_logic_vector(31 downto 0);
		clean				: std_logic;
		mntn_restart	: std_logic;
		mntn_tid			: std_logic_vector(2 downto 0);
	end record;
	
	type dctlin_type is record
		mcb_data			: std_logic_vector(31 downto 0);
		mcb_empty		: std_logic;
		mcb_cmd_full	: std_logic;
		restarted		: std_logic_vector(7 downto 0);
		tag				: std_logic_vector(DM_BITS-1+4 downto 10); --ASID
		ownst				: std_logic_vector(7 downto 0);
	end record;
	
end package;


