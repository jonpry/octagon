----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:22 04/23/2013 
-- Design Name: 
-- Module Name:    octagon - Behavioral 
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

entity octagon is
	Port ( 
		clk 				: in  std_logic;
		running 			: in std_logic_vector(7 downto 0);
		int 				: in std_logic_vector(7 downto 0);
		wbmoutsigs		: out wbmoutsig_type;
		wbcyc				: in std_logic;
		wback				: in std_logic;
		wbdata			: in std_logic_vector(31 downto 0);
		mcb_cmd			: out std_logic_vector(2 downto 0);
		mcb_bl			: out std_logic_vector(5 downto 0);
		mcb_adr			: out std_logic_vector(29 downto 0);
		mcb_rden			: out std_logic;
		mcb_en			: out std_logic;
		mcb_data			: in std_logic_vector(31 downto 0);
		mcb_empty		: in std_logic;
		mcb_cmd_full	: in std_logic;
		dmcb_cmd			: out std_logic_vector(2 downto 0);
		dmcb_bl			: out std_logic_vector(5 downto 0);
		dmcb_adr			: out std_logic_vector(29 downto 0);
		dmcb_rden		: out std_logic;
		dmcb_en			: out std_logic;
		dmcb_data		: in std_logic_vector(31 downto 0);
		dmcb_empty		: in std_logic;
		dmcb_cmd_full	: in std_logic;
		dmcb_dout		: out std_logic_vector(31 downto 0);
		dmcb_wren		: out std_logic;
		cpu_dbg_vector : out std_logic_vector(63 downto 0)
	);
end octagon;

architecture Behavioral of octagon is

signal pcin : pcin_type;
signal pcout : pcout_type;
signal icin : icfetchin_type;
signal icout : icfetchout_type;
signal dcin : dcfetchin_type;
signal dcout : dcfetchout_type;
signal imuxout : icmuxout_type;
signal dmuxout : dcmuxout_type;
signal lmuxout : lmuxout_type;
signal decout : decout_type;
signal rin : rfetchin_type;
signal rout : rfetchout_type;
signal alu1in	: alu1in_type;
signal alu1out : alu1out_type;
signal alu2out : alu2out_type;
signal jumpout : jumpout_type;
signal rstoreout : rstoreout_type;
signal dcmemin : dcmemin_type; 
signal dcmemout : dcmemout_type;
signal ictlin : ictlin_type;
signal ictlout : ictlout_type;
signal dctlin : dctlin_type;
signal dctlout : dctlout_type;
signal wbmout : wbmout_type;
signal wbmin : wbmin_type;
signal wbrout : wbrout_type;
signal wbrin : wbrin_type;

signal cpu_dbg_vector_i : std_logic_vector(63 downto 0);

begin

--cpu_dbg_vector <= cpu_dbg_vector_i;

cpu_dbg_vector_i(31) <= int(0);
cpu_dbg_vector_i(30) <= running(0);
cpu_dbg_vector_i(29) <= pcout.valid;
process(clk)
begin
	if clk='1' and clk'Event then
		if pcout.valid = '1' then
			cpu_dbg_vector_i(IM_BITS-1 downto 0) <= pcout.pc;
		end if;
		if decout.valid = '1' then
			cpu_dbg_vector_i(63 downto 32) <= decout.instr;
		end if;
	end if;
end process;

--1 PC
--2 Tag
--3 Mux
--4 decode
--5 R fetch
--6 alu 
--7 alu / dc_tag
--8 alu - jump - load stall - or stall if store still pending
--9 alu
--11 store

pcin.jump_target <= jumpout.jump_target;
pcin.do_int <= jumpout.do_int;
pcin.pc <= jumpout.pc;
pcin.running <= running;
pcin.int <= int;
pcin.jump <= jumpout.do_jump;
pcin.cvalid <= jumpout.cvalid;
pcin.abort <= jumpout.abort;
pcin.restarts <= ictlout.restarts or dctlout.restarts or wbmout.restarts or wbrout.restarts;

icin.pcout <= pcout;
icin.tagval <= ictlout.tagadr(IM_BITS-1+4 downto 10); --ASID
icin.tagadr <= ictlout.tagadr(9 downto 6);
icin.tagidx <= ictlout.tagidx;
icin.tagwe <= ictlout.tag_wr;
icin.imemval <= ictlout.data;
icin.imemadr <= ictlout.memadr(9 downto 2);
icin.imemidx <= ictlout.tagidx;
icin.imemwe <= ictlout.memwe;

mcb_cmd <= ictlout.mcb_cmd;
mcb_bl <= ictlout.mcb_bl;
mcb_adr <= ictlout.mcb_adr;
mcb_rden <= ictlout.mcb_rden;
mcb_en <= ictlout.mcb_en;
ictlin.mcb_data <= mcb_data;
ictlin.mcb_empty <= mcb_empty;
ictlin.mcb_cmd_full <= mcb_cmd_full;
ictlin.restarted <= pcout.restarted;
ictlin.ownst <= icout.ownst;

dmcb_cmd <= dctlout.mcb_cmd;
dmcb_bl <= dctlout.mcb_bl;
dmcb_adr <= dctlout.mcb_adr;
dmcb_rden <= dctlout.mcb_rden;
dmcb_wren <= dctlout.mcb_wren;
dmcb_en <= dctlout.mcb_en;
dmcb_dout <= dctlout.mcb_data;
dctlin.mcb_data <= dmcb_data;
dctlin.mcb_empty <= dmcb_empty;
dctlin.mcb_cmd_full <= dmcb_cmd_full;
dctlin.restarted <= pcout.restarted;
dctlin.tag <= dcout.tag;
dctlin.ownst <= dcout.ownst;

dcin.adr <= alu1out.memadr;
dcin.tid <= alu1out.tid;
dcin.asid <= alu1out.asid;
dcin.dcache_op <= alu1out.dcache_op;
dcin.cacheop <= alu1out.cacheop;
dcin.cache_p <= alu1out.cache_p;
dcin.tagval <= dctlout.tagadr(IM_BITS-1+4 downto 10); --ASID
dcin.tagadr <= dctlout.tagadr(9 downto 6);
dcin.tagidx <= dctlout.tagidx;
dcin.tagwe <= dctlout.tag_wr;
dcin.mntn_restart <= dctlout.mntn_restart;
dcin.mntn_tid <= dctlout.mntn_tid;

dcmemin.dmemval <= dctlout.data;
dcmemin.dmemadr <= dctlout.memadr(9 downto 2);
dcmemin.dmemidx <= dctlout.tagidx;
dcmemin.dmemwe <= dctlout.memwe;
dcmemin.dclean <= dctlout.clean;
dcmemin.alu2out <= alu2out;
dcmemin.dcout <= dcout;

rin.decout <= decout;
rin.reg_val <= rstoreout.smux;
rin.reg_adr <= rstoreout.tid & rstoreout.r_dest;
rin.reg_we <= rstoreout.valid;
rin.reg_be <= rstoreout.be;

alu1in.rfetch <= rout;
alu1in.rout <= rstoreout;
alu1in.wbrout <= wbrout;

wbmoutsigs <= wbmout.sigs;
wbmin.restarted <= pcout.restarted;
wbmin.cyc <= wbcyc;
wbmin.ack <= wback;
wbmin.dat <= wbdata;

wbrin.restarted <= pcout.restarted;
wbrin.dat <= wbmout.wbrin.dat;
wbrin.valid <= wbmout.wbrin.valid;
wbrin.tid <= wbmout.wbrin.tid;

pc_module: entity work.pc_module port map(clk,pcin,pcout);  --1

ic_fetch : entity work.ic_fetch port map(clk,icin,icout);	--2

ic_mux : entity work.ic_mux port map(clk,icout,imuxout);		--3

decode : entity work.decode port map(clk,imuxout,decout);	--4
icontrol : entity work.icontrol port map(clk,imuxout,ictlin,ictlout);

r_fetch : entity work.r_fetch port map(clk,rin,rout);			--5
wbreader : entity work.wbreader port map(clk,wbrin,decout,wbrout);

alu1 : entity work.alu1 port map(clk,alu1in,alu1out);			--6

alu2 : entity work.alu2 port map(clk,alu1out,alu2out);		--7
dc_fetch : entity work.dc_fetch port map(clk,dcin,dcout);

jump : entity work.jump port map(clk,alu2out,int,dcout,wbmout,jumpout);	--8
dc_mem : entity work.dc_mem port map(clk,dcmemin,dcmemout);
wb_master : entity work.wb_master port map(clk,dcmemin,wbmin,wbmout);

dcontrol : entity work.dcontrol port map(clk,dcmemout,dctlin,dctlout);
dc_mux : entity work.dc_mux port map(clk,jumpout,dcmemout,dmuxout); --8+1

l_mux : entity work.l_mux port map(clk,dmuxout,lmuxout); --8+2

r_store : entity work.r_store port map(clk,lmuxout,rstoreout); --8+2.5 -- async on output of l_mux

end Behavioral;

