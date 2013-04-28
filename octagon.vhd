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
		notrim_o 		: out std_logic_vector(20 downto 0);
		wbmout			: out wbmout_type;
		tagidx			: in std_logic_vector(2 downto 0);
		tagadr			: in std_logic_vector(3 downto 0);
		tagval			: in std_logic_vector(IM_BITS-1 downto 10);
		itagwe			: in std_logic;
		imemidx			: in std_logic_vector(2 downto 0);
		imemadr			: in std_logic_vector(7 downto 0);
		imemval			: in std_logic_vector(31 downto 0);
		imemwe			: in std_logic;
		dtagwe			: in std_logic;
		dmemidx			: in std_logic_vector(2 downto 0);
		dmemadr			: in std_logic_vector(7 downto 0);
		dmemval			: in std_logic_vector(31 downto 0);
		dmemwe			: in std_logic
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

begin

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
pcin.running <= running;
pcin.int <= int;
pcin.jump <= jumpout.do_jump;
pcin.valid <= jumpout.valid;

icin.pcout <= pcout;
icin.tagval <= tagval;
icin.tagadr <= tagadr;
icin.tagidx <= tagidx;
icin.tagwe <= itagwe;
icin.imemval <= imemval;
icin.imemadr <= imemadr;
icin.imemidx <= imemidx;
icin.imemwe <= imemwe;

dcin.adr <= alu1out.memadr;
dcin.tagval <= tagval;
dcin.tagadr <= tagadr;
dcin.tagidx <= tagidx;
dcin.tagwe <= dtagwe;

dcmemin.dmemval <= dmemval;
dcmemin.dmemadr <= dmemadr;
dcmemin.dmemidx <= dmemidx;
dcmemin.dmemwe <= dmemwe;
dcmemin.alu2out <= alu2out;
dcmemin.dcout <= dcout;

rin.decout <= decout;
rin.reg_val <= rstoreout.smux;
rin.reg_adr <= rstoreout.tid & rstoreout.r_dest;
rin.reg_we <= rstoreout.valid;

alu1in.rfetch <= rout;
alu1in.rout <= rstoreout;

pc_module: entity work.pc_module port map(clk,pcin,pcout);  --1

ic_fetch : entity work.ic_fetch port map(clk,icin,icout);	--2

ic_mux : entity work.ic_mux port map(clk,icout,imuxout);		--3

decode : entity work.decode port map(clk,imuxout,decout);	--4

r_fetch : entity work.r_fetch port map(clk,rin,rout);			--5

alu1 : entity work.alu1 port map(clk,alu1in,alu1out);			--6

alu2 : entity work.alu2 port map(clk,alu1out,alu2out);		--7
dc_fetch : entity work.dc_fetch port map(clk,dcin,dcout);

jump : entity work.jump port map(clk,alu2out,int,jumpout);		--8
dc_mem : entity work.dc_mem port map(clk,dcmemin,dcmemout);
wb_master : entity work.wb_master port map(clk,dcmemin,wbmout);

dc_mux : entity work.dc_mux port map(clk,jumpout,dcmemout,dmuxout); --8+1

l_mux : entity work.l_mux port map(clk,dmuxout,lmuxout); --8+2

r_store : entity work.r_store port map(clk,lmuxout,rstoreout); --8+2.5 -- async on output of l_mux

process(clk)
variable notrim : std_logic_vector(20 downto 0);
begin
	if clk='1' and clk'Event then

		
		notrim := (others => '0');
--		notrim (15 downto 0) := rsave(15 downto 0) or decout.long_target(15 downto 0);
--		notrim (9 downto 0) := notrim(9 downto 0) or decout.long_target(25 downto 16);
		
--		notrim(4 downto 0) := notrim(4 downto 0) or decout.r_dest;
--		notrim(11 downto 10) := notrim(11 downto 10) or decout.memsize;
--		notrim(15) := notrim(16) or decout.link;
--		notrim(16) := notrim(16) or decout.rfe;
--		notrim(16) := notrim(16) or decout.load;
--		notrim(17) := notrim(17) or decout.store;
--		notrim(17) := notrim(17) or decout.load_unsigned;
--		notrim(17) := notrim(17) or decout.long_jump;
--		notrim(18) := notrim(18) or jumpout.met;
--		notrim(18) := notrim(18) or decout.slt;
		notrim(19) := notrim(19) or alu2out.arith_ovf;
	--	notrim(19) := notrim(19) or decout.logic;
	--	notrim(19) := notrim(19) or alu2out.ltu;
--		notrim(20) := notrim(20) or decout.jump;
--		notrim(20) := notrim(20) or decout.math_unsigned;
	--	notrim(20) := notrim(20) or alu2out.lt;

	--	rsave2 <= notrim;
	--	notrim := rsave2;
		
	--	notrim(15 downto 0) := notrim(15 downto 0) or alu1out.memadr(15 downto 0) or ( (31 downto DM_BITS => '0') & alu1out.memadr((DM_BITS-1) downto 16));
	--	notrim(15 downto 0) := notrim(15 downto 0) or alu2out.diff(15 downto 0) or alu2out.diff(31 downto 16);
	 	
	--	rsave3 <= notrim;
	--	notrim := rsave3;
		
	--	notrim(15 downto 0) := notrim(15 downto 0) or alu2out.logic(15 downto 0) or alu2out.logic(31 downto 16);
		
		notrim_o <= notrim;


	end if;
end process;

end Behavioral;

