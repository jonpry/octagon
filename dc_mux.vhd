----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:20:29 04/23/2013 
-- Design Name: 
-- Module Name:    ic_mux - Behavioral 
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

entity dc_mux is
	Port ( 
		clk : in  std_logic;
		jumpout : in jumpout_type;
		memout : in dcmemout_type;
		muxout : out dcmuxout_type
	);
end dc_mux;

architecture Behavioral of dc_mux is

begin

process(clk)
	variable sel : std_logic_vector(2 downto 0);
	variable selin : std_logic_vector(7 downto 0);
begin
	if clk='1' and clk'Event then
		muxout.tid <= jumpout.tid;
		muxout.r_dest <= jumpout.r_dest;
		muxout.reg_store <= jumpout.reg_store;
		muxout.store_cond <= jumpout.store_cond;
		muxout.met <= jumpout.met;
		muxout.valid <= jumpout.valid;
		muxout.lmux <= jumpout.lmux;
		muxout.slt <= jumpout.slt;
		muxout.mux <= jumpout.mux;
		muxout.shiftout <= jumpout.shiftout;
		muxout.data <= memout.data(to_integer(unsigned(memout.sel)));
		muxout.memsize <= jumpout.memsize;
		muxout.memadr <= jumpout.memadr;
		muxout.load <= jumpout.load;
		muxout.load_unsigned <= jumpout.load_unsigned;
		muxout.store_cop0 <= jumpout.store_cop0;
		muxout.do_int <= jumpout.do_int;
		muxout.epc <= jumpout.epc;
		muxout.ipend <= jumpout.ipend;
		muxout.store_hi <= jumpout.store_hi;
		muxout.store_lo <= jumpout.store_lo;
		muxout.rfe <= jumpout.rfe;
	end if;
end process;

end Behavioral;

