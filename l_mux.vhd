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
		lout.rfe <= dmuxout.rfe;
		lout.mtmul <= dmuxout.mtmul;

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
	variable be		  : std_logic_vector(3 downto 0);
begin
	if clk='1' and clk'Event then
		case dmuxout.lmux is
			when lmux_shift	=> lout.lmux <= dmuxout.shiftout;
			when lmux_jmux		=> lout.lmux <= dmuxout.mux;
			when lmux_slt		=> lout.lmux <= (30 downto 0=>'0') & dmuxout.slt;
		end case;
		
		lout.wbr_complete <= dmuxout.wbr_complete;
		lout.wbr_data <= dmuxout.wbr_data;
		
		data := dmuxout.data;
		
	--Barrel shifter sign extender thingy for loads
		case dmuxout.memsize is
			when "00"	=> signbit := dmuxout.data(7);
			when "01"	=> signbit := dmuxout.data(15);
			when others => signbit := dmuxout.data(31);
		end case;
		
		if signbit = '1' and dmuxout.load_unsigned = '0' then
			signvec := (others => '1');
		else
			signvec := (others => '0');
		end if;
		
		case dmuxout.memsize is
			when "00"   => data := signvec & signvec & signvec & dmuxout.data(7 downto 0);
			when "01"   => data := signvec & signvec & dmuxout.data(15 downto 0);
			when others => data := dmuxout.data;
		end case;
	
		case dmuxout.memadr is
			when "00"	=> lout.loadv <= data;
			when "01"	=> lout.loadv <= data(7 downto 0) & data(31 downto 8);
			when "10"	=> lout.loadv <= data(15 downto 0) & data(31 downto 16);
			when others	=> lout.loadv <= data(23 downto 0) & data(31 downto 24);		
		end case;
		
		case dmuxout.memadr is
			when "00"	=> be := "1111";
			when "01"	=> be := "0111";
			when "10"	=> be := "0011";
			when others	=> be := "0001";		
		end case;
		
		if dmuxout.ls_left = '1' then
			lout.be <= not be;
		elsif dmuxout.ls_right = '1' then
			lout.be <= be;
		else
			lout.be <= "1111";
		end if;

		lout.load <= dmuxout.load;
	end if;
end process;

end Behavioral;

