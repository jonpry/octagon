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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.octagon_types.all;
use work.octagon_funcs.all;

entity l_mux is
	Port ( 
		clk : in  std_logic;
		dmuxout : in dcmuxout_type;
		lout : out lmuxout_type
	);
end l_mux;

architecture Behavioral of l_mux is

begin

--Control signals
process(clk)
begin
	if clk='1' and clk'Event then
		lout.tid <= dmuxout.tid;
		lout.r_dest <= dmuxout.r_dest;
		lout.store_cop0 <= dmuxout.store_cop0;
		lout.epc <= dmuxout.epc;
		lout.ipend <= dmuxout.ipend;
		lout.do_int <= dmuxout.do_int;

		--Valid here really mean reg write
		if dmuxout.reg_store = '1' or (dmuxout.store_cond = '1' and dmuxout.met = '1') then
			lout.valid <= to_std_logic(dmuxout.valid='1' and dmuxout.r_dest /= "00000");
		else
			lout.valid <= '0';
		end if;
		
		lout.store_cop0 <= to_std_logic(dmuxout.valid='1' and dmuxout.store_cop0 = '1');
		lout.store_hi <= to_std_logic(dmuxout.valid='1' and dmuxout.store_hi='1');
		lout.store_lo <= to_std_logic(dmuxout.valid='1' and dmuxout.store_lo = '1');
	end if;
end process;

--Lmux
process(clk)
	variable data 	  : std_logic_vector(31 downto 0);
	variable signbit : std_logic;
	variable signvec : std_logic_vector(7 downto 0);
begin
	if clk='1' and clk'Event then
		case dmuxout.lmux is
			when lmux_shift	=> lout.lmux <= dmuxout.shiftout;
			when lmux_jmux		=> lout.lmux <= dmuxout.mux;
			when lmux_slt		=> lout.lmux <= (30 downto 0=>'0') & dmuxout.slt;
		end case;
		
		data := dmuxout.data;
		
	--Barrel shifter sign extender thingy for loads
		case dmuxout.memsize is
			when "00"	=> signbit := data(7);
			when "01"	=> signbit := data(15);
			when others => signbit := data(31);
		end case;
		
		if signbit = '1' and dmuxout.load_unsigned = '0' then
			signvec := (others => '1');
		else
			signvec := (others => '0');
		end if;
	
		case dmuxout.memadr is
			when "00"	=> lout.loadv(7 downto 0) <= data(7 downto 0);
			when "01"	=> lout.loadv(7 downto 0) <= data(15 downto 8);
			when "10"	=> lout.loadv(7 downto 0) <= data(23 downto 16);
			when "11"	=> lout.loadv(7 downto 0) <= data(31 downto 24);		
			when others => lout.loadv(7 downto 0) <= (others => 'X');
		end case;

		--sz = "00", then data <= signvec
		--sz = "01", if adr 00, data <= data, else data <= data >> 16
		--sz = "XX", data <= data.
		
		if dmuxout.memsize = "00" then
			lout.loadv(15 downto 8) <= signvec;
		else
			if dmuxout.memadr = "10" then
				lout.loadv(15 downto 8) <= data(31 downto 24);
			else
				lout.loadv(15 downto 8) <= data(15 downto 8);
			end if;
		end if;
		
		if dmuxout.memsize(1) = '1' then
			lout.loadv(31 downto 16) <= data(31 downto 16);
		else
			lout.loadv(31 downto 16) <= signvec & signvec;
		end if;
	
		lout.load <= dmuxout.load;
	end if;
end process;

end Behavioral;

