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

entity ic_mux is
	Port ( 
		clk : in  std_logic;
		fetchout : in icfetchout_type;
		muxout : out icmuxout_type
	);
end ic_mux;

architecture Behavioral of ic_mux is

begin

process(clk)
	variable sel : std_logic_vector(2 downto 0);
	variable selin : std_logic_vector(7 downto 0);
begin
	if clk='1' and clk'Event then
		muxout.pc <= fetchout.pc;
		muxout.tid <= fetchout.tid;
		
--		present := '0';
--		if fetchout.owns(0) = '1' then
--			muxout.instr <= fetchout.instr0;
--			present := fetchout.present(0);
--		elsif fetchout.owns(1) = '1' then
--			muxout.instr <= fetchout.instr1;
--			present := fetchout.present(1);
--		elsif fetchout.owns(2) = '1' then
--			muxout.instr <= fetchout.instr2;
--			present := fetchout.present(2);
--		elsif fetchout.owns(3) = '1' then
--			muxout.instr <= fetchout.instr3;
--			present := fetchout.present(3);
--		elsif fetchout.owns(4) = '1' then
--			muxout.instr <= fetchout.instr4;
--			present := fetchout.present(4);
--		elsif fetchout.owns(5) = '1' then
--			muxout.instr <= fetchout.instr5;
--			present := fetchout.present(5);
--		elsif fetchout.owns(6) = '1' then
--			muxout.instr <= fetchout.instr6;
--			present := fetchout.present(6);
--		else
--			muxout.instr <= fetchout.instr7;
--			present := fetchout.present(7);
--		end if;

		--Second attempt. by using one hot decoder. XST predicts slower speed. But synth is faster. 

		selin := fetchout.owns;
		sel(0) := to_std_logic(selin(1)='1' or selin(3)='1' or selin(5)='1' or selin(7)='1');
		sel(1) := to_std_logic(selin(2)='1' or selin(3)='1' or selin(6)='1' or selin(7)='1');
		sel(2) := to_std_logic(selin(4)='1' or selin(5)='1' or selin(6)='1' or selin(7)='1');
		
		muxout.instr <= fetchout.instr(to_integer(unsigned(sel)));
	
	
		--TODO: this is a miss, need to handle it
		if fetchout.owns = "00000000" then
			muxout.valid <= '0';
		else
			muxout.valid <= fetchout.valid;
		end if;
	end if;
end process;

end Behavioral;

