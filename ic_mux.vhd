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

type instr_type is array (0 to 7) of std_logic_vector(31 downto 0);

signal instr_save : instr_type := (others => (others => '0'));
signal instr_valid : std_logic_vector(7 downto 0) := (others => '0');

begin

process(clk)
	variable sel : std_logic_vector(2 downto 0);
	variable selin : std_logic_vector(7 downto 0);
	variable instr : std_logic_vector(31 downto 0);
begin
	if clk='1' and clk'Event then
		muxout.pc <= fetchout.pc;
		muxout.tid <= fetchout.tid;
		muxout.ibuf_match <= fetchout.ibuf_match and instr_valid(to_integer(unsigned(fetchout.tid))) and fetchout.valid;
		
		--Second attempt. by using one hot decoder. XST predicts slower speed. But synth is faster. 

		selin := fetchout.owns;
		sel(0) := to_std_logic(selin(1)='1' or selin(3)='1' or selin(5)='1' or selin(7)='1');
		sel(1) := to_std_logic(selin(2)='1' or selin(3)='1' or selin(6)='1' or selin(7)='1');
		sel(2) := to_std_logic(selin(4)='1' or selin(5)='1' or selin(6)='1' or selin(7)='1');
		
		instr := fetchout.instr(to_integer(unsigned(sel)));
		muxout.instr <= instr;
		if fetchout.ibuf_match = '1' and instr_valid(to_integer(unsigned(fetchout.tid))) = '1' then
			muxout.instr <= instr_save(to_integer(unsigned(fetchout.tid)));
		else
			instr_save(to_integer(unsigned(fetchout.tid))) <= instr;
		end if;
		
		if selin /= "00000000" then
			instr_valid(to_integer(unsigned(fetchout.tid))) <= fetchout.valid;
		else
			if fetchout.ibuf_match = '0' and fetchout.valid = '1' then
				instr_valid(to_integer(unsigned(fetchout.tid))) <= '0';
			end if;
		end if;
		
	   muxout.asid  <= fetchout.asid;
		muxout.tlb	 <= fetchout.tlb;
		muxout.ksu	 <= fetchout.ksu;
		muxout.exc	 <= fetchout.exc;
		muxout.sv	 <= fetchout.sv;
	
		--this is a miss, need to handle it
		if selin = "00000000" then
			muxout.valid <= '0'; --to_std_logic(fetchout.valid = '1' and fetchout.ibuf_match = '1');
			muxout.imiss <= fetchout.valid; --to_std_logic(fetchout.valid = '1' and fetchout.ibuf_match = '0');
		else
			muxout.imiss <= '0';
			muxout.valid <= fetchout.valid; --TODO: this produces valid even on tlbmiss!!!!!!!!!!!!!!!!!!!!!!!!!!!
		end if;
	end if;
end process;

end Behavioral;

