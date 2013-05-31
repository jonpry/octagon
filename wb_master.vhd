----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:22:00 04/26/2013 
-- Design Name: 
-- Module Name:    dc_mem - Behavioral 
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

entity wb_master is
	Port ( 
		clk : in  std_logic;
		dcin : in dcmemin_type;
		wbin : in wbmin_type;
		wbout : out wbmout_type
	);
end wb_master;

architecture Behavioral of wb_master is

type adr_type is array (0 to 15) of std_logic_vector(DM_BITS-1 downto 0);
type dat_type is array (0 to 15) of std_logic_vector(31 downto 0);

signal adrmem : adr_type;
signal datmem : dat_type;

signal wrptr : unsigned(3 downto 0) := "0000";
signal rdptr : unsigned(3 downto 0) := "0000";

signal stall : std_logic;
signal restarts : std_logic_vector(7 downto 0) := X"00";

begin

wbout.stall <= stall;
wbout.restarts <= restarts;

process(clk)
begin
	if clk='1' and clk'Event then
		restarts <= restarts and not wbin.restarted;

		--Stall is a signal to parallel stage, so we predict if the next 
		stall <= to_std_logic((wrptr + 2 = rdptr) or (wrptr + 1 = rdptr));
		if dcin.dcout.nc = '1' and dcin.alu2out.valid = '1' and dcin.alu2out.dcwren = '1' then
			if stall = '1' then
				--Jump unit will stall but we immediately cause restart
				restarts(to_integer(unsigned(dcin.alu2out.tid))) <= '1';
			else
				wrptr <= wrptr + 1;
				adrmem(to_integer(wrptr)) <= dcin.alu2out.dcwradr;
				datmem(to_integer(wrptr)) <= dcin.alu2out.store_data;
			end if;
		end if;
	end if;
end process;

process(clk)
begin
	if clk='1' and clk'Event then
		if rdptr /= wrptr then
			wbout.req <= '1';
			if wbin.cyc = '1' then
				wbout.adr <= adrmem(to_integer(rdptr));
				wbout.data <= datmem(to_integer(rdptr));
				rdptr <= rdptr + 1;
			end if;
		else
			wbout.req <= '0';
		end if;
	end if;
end process;

end Behavioral;

