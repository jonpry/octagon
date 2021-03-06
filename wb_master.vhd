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
type tid_type is array (0 to 15) of std_logic_vector(2 downto 0);

signal adrmem : adr_type;
signal datmem : dat_type;
signal tidmem : tid_type;
signal wrmem  : std_logic_vector(15 downto 0);

signal wrptr : unsigned(3 downto 0) := "0000";
signal rdptr : unsigned(3 downto 0) := "0000";

signal stall : std_logic;
signal restarts : std_logic_vector(7 downto 0) := X"00";

signal read_done : std_logic := '0';

begin

wbout.stall <= stall;
wbout.restarts <= restarts;
wbout.wbrin.valid <= read_done;

process(clk)
	variable wren : std_logic;
begin
	if clk='1' and clk'Event then
		restarts <= restarts and not wbin.restarted;

		--Stall is a signal to parallel stage, so we predict if the next 
		stall <= to_std_logic((wrptr + 2 = rdptr) or (wrptr + 1 = rdptr));
		if dcin.dcout.nc = '1' and dcin.alu2out.valid = '1' and dcin.alu2out.dcop = '1' and dcin.alu2out.wbr_complete = '0' then
			wren := dcin.alu2out.dcwren;
			--TODO: read operations stall on fifo full and unconditionally without restart
			if stall = '1' then
				--Jump unit will stall but we immediately cause restart
				restarts(to_integer(unsigned(dcin.alu2out.tid))) <= '1';
			else
				wrptr <= wrptr + 1;
				adrmem(to_integer(wrptr)) <= dcin.alu2out.dcwradr;
				datmem(to_integer(wrptr)) <= dcin.alu2out.store_data;
				tidmem(to_integer(wrptr)) <= dcin.alu2out.tid;
				wrmem(to_integer(wrptr)) <= wren;
			end if;
		end if;
	end if;
end process;

process(clk)
	variable wren : std_logic;
begin
	if clk='1' and clk'Event then	
		read_done <= '0';
		if rdptr /= wrptr then
			wbout.sigs.req <= '1';
			--TODO: another read instruction cannot be tended until the first has reentered the pipeline
			if wbin.cyc = '1' then
				wbout.sigs.adr <= adrmem(to_integer(rdptr));
				wbout.sigs.data <= datmem(to_integer(rdptr));
				wren := wrmem(to_integer(rdptr));
				wbout.sigs.wren <= wren;
				rdptr <= rdptr + 1;
				if wbin.ack ='1' and wren = '0' then
					--read complete
					wbout.wbrin.dat <= wbin.dat;
					wbout.wbrin.tid <= tidmem(to_integer(rdptr));
					read_done <= '1';
				end if;
			end if;
		else
			wbout.sigs.req <= '0';
		end if;
	end if;
end process;

end Behavioral;

