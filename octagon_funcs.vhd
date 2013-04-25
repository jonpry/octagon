----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:31:01 04/25/2013 
-- Design Name: 
-- Module Name:    octagon_funcs - Behavioral 
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

package octagon_funcs is

    function to_std_logic(L: BOOLEAN) return std_logic is
    begin
        if L then
            return('1');
        else
            return('0');
        end if;
    end function to_std_logic; 
	 
	 function shift(constant amt : Integer; 
						 I: std_logic_vector(31 downto 0); 
						 shiftopi : shiftop_type;
						 do : std_logic) 
						 return std_logic_vector is
			variable O : std_logic_vector(31 downto 0);
			variable shiftop : shiftop_type;
    begin
			if do = '1' then
				shiftop := shiftop_none;
			else
				shiftop := shiftopi;
			end if;

			case shiftop is
				when shiftop_none			=> return I;
				when shiftop_left			=> return I((31 - amt) downto 0) & (amt downto 1 => '0');
				when shiftop_right		=> return (amt downto 1 => '0') & I(31 downto amt);
				when shiftop_right_neg	=> return (amt downto 1 => '1') & I(31 downto amt);
			end case;
    end function shift; 
	
end package;


