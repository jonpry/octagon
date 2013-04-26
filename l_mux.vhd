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

entity l_mux is
	Port ( 
		clk : in  std_logic;
		jumpout : in jumpout_type;
		muxout : in dcmuxout_type;
		lout : out lmuxout_type
	);
end l_mux;

architecture Behavioral of l_mux is

begin

--Control signals
process(clk)
begin
	if clk='1' and clk'Event then
		lout.tid <= jumpout.tid;
		lout.r_dest <= jumpout.r_dest;

		if jumpout.reg_store = '1' or (jumpout.store_cond = '1' and jumpout.met = '1') then
			lout.valid <= to_std_logic(jumpout.valid='1' and jumpout.r_dest /= "00000");
		else
			lout.valid <= '0';
		end if;
	end if;
end process;

--Lmux
process(clk)
	variable signbit : std_logic;
	variable signvec : std_logic_vector(7 downto 0);
begin
	if clk='1' and clk'Event then
		case jumpout.lmux is
			when lmux_shift	=> lout.lmux <= jumpout.shiftout;
			when lmux_jmux		=> lout.lmux <= jumpout.mux;
			when lmux_slt		=> lout.lmux <= jumpout.slt;
		end case;
		
	--Barrel shifter sign extender thingy for loads
		case jumpout.memsize is
			when "00"	=> signbit := muxout.data(7);
			when "01"	=> signbit := muxout.data(15);
			when others => signbit := muxout.data(31);
		end case;
		
		if signbit = '1' and jumpout.load_unsigned = '0' then
			signvec := (others => '1');
		else
			signvec := (others => '0');
		end if;
	
		case jumpout.memadr is
			when "00"	=> lout.loadv(7 downto 0) <= muxout.data(7 downto 0);
			when "01"	=> lout.loadv(7 downto 0) <= muxout.data(15 downto 8);
			when "10"	=> lout.loadv(7 downto 0) <= muxout.data(23 downto 16);
			when "11"	=> lout.loadv(7 downto 0) <= muxout.data(31 downto 24);		
			when others => lout.loadv(7 downto 0) <= (others => 'X');
		end case;

		--sz = "00", then data <= signvec
		--sz = "01", if adr 00, data <= data, else data <= data >> 16
		--sz = "XX", data <= data.
		
		if jumpout.memsize = "00" then
			lout.loadv(15 downto 8) <= signvec;
		else
			if jumpout.memadr = "10" then
				lout.loadv(15 downto 8) <= muxout.data(31 downto 24);
			else
				lout.loadv(15 downto 8) <= muxout.data(15 downto 8);
			end if;
		end if;
		
		if jumpout.memsize(1) = '1' then
			lout.loadv(31 downto 16) <= muxout.data(31 downto 16);
		else
			lout.loadv(31 downto 16) <= signvec & signvec;
		end if;
	
		lout.load <= jumpout.load;
	end if;
end process;

end Behavioral;

