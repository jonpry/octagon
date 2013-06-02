----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:45:10 04/26/2013 
-- Design Name: 
-- Module Name:    r_store - Behavioral 
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

entity r_store is
	Port ( 
		clk : in  std_logic;
		lmuxout : in lmuxout_type;
		rout : out rstoreout_type
	);
end r_store;

architecture Behavioral of r_store is

signal loadv : std_logic_vector(31 downto 0);

begin

--Control signals
rout.tid <= lmuxout.tid;
rout.r_dest <= lmuxout.r_dest;
rout.valid <= lmuxout.valid;

--Smux
loadv <= lmuxout.wbr_data when lmuxout.wbr_complete = '1' else lmuxout.loadv;
rout.smux <= loadv when lmuxout.load = '1' else lmuxout.lmux;

process(clk)
	variable status_wr : std_logic;
begin
	if clk='1' and clk'Event then
		if lmuxout.do_int = '1' then
			rout.cop0.epc <= (31 downto IM_BITS => '0') & lmuxout.epc;
			rout.cop0.ipend <= lmuxout.ipend;
			rout.cop0.ecode <= X"1";
			rout.cop0.exc <= '1';
			rout.epc_wr <= '1';
			rout.cause_wr <= '1';
			
			rout.exc_wr <= '1';
			rout.int_wr <= '0';
		else
			status_wr := to_std_logic(lmuxout.r_dest = "01100" and lmuxout.store_cop0 = '1');

			if lmuxout.rfe = '1' then
				rout.cop0.exc <= '0';
				rout.exc_wr <= '1';
			else
				rout.cop0.exc <= lmuxout.lmux(1);
				rout.exc_wr <= status_wr;
			end if;
			rout.cop0.epc <= lmuxout.lmux;
			rout.epc_wr <= to_std_logic(lmuxout.r_dest = "01110" and lmuxout.store_cop0 = '1');

			rout.cop0.imask <= lmuxout.lmux(15 downto 8);

			rout.cop0.int <= lmuxout.lmux(0);
			rout.int_wr <= status_wr;

			rout.cop0.ecode <= lmuxout.lmux(5 downto 2);
			rout.cop0.ipend <= lmuxout.lmux(15 downto 8);
			rout.cause_wr <= to_std_logic(lmuxout.r_dest = "01101" and lmuxout.store_cop0 = '1');


		end if;
		
		rout.cop0_tid <= lmuxout.tid;
		rout.hi <= lmuxout.lmux;
		rout.lo <= lmuxout.lmux;
		
		rout.hi_wr <= lmuxout.store_hi;
		rout.lo_wr <= lmuxout.store_lo;
	
	end if;
end process;

end Behavioral;

