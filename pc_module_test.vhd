--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:03:27 04/23/2013
-- Design Name:   
-- Module Name:   /opt/Xilinx/14.1/ISE_DS/projects/mips8/pc_module_test.vhd
-- Project Name:  mips8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pc_module
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

use work.octagon_types.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY pc_module_test IS
END pc_module_test;
 
ARCHITECTURE behavior OF pc_module_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pc_module
    PORT(
         clk : IN  std_logic;
         pcin : IN  pcin_type;
         pcout : OUT  pcout_type
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal pcin : pcin_type;

 	--Outputs
   signal pcout : pcout_type;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pc_module PORT MAP (
          clk => clk,
          pcin => pcin,
          pcout => pcout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		pcin.running <= (others => '0');
		pcin.valid <= '0';
		pcin.jump <= '0';

      wait for clk_period*10;
		
		pcin.running <= "00000001";
		
		wait for clk_period;
		
		pcin.valid <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
