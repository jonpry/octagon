--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:50:45 04/23/2013
-- Design Name:   
-- Module Name:   /opt/Xilinx/14.1/ISE_DS/projects/mips8/octagon_test.vhd
-- Project Name:  mips8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: octagon
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

use work.octagon_types.all;
 
ENTITY octagon_test IS
END octagon_test;
 
ARCHITECTURE behavior OF octagon_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT octagon
    PORT(
         clk : IN  std_logic;
   		pcin : in pcin_type;
			notrim_o : out std_logic_vector(IM_BITS-1 downto 0);
         tagidx : IN  std_logic_vector(2 downto 0);
         tagadr : IN  std_logic_vector(3 downto 0);
         tagval : IN  std_logic_vector(25 downto 10);
         tagwe : IN  std_logic;
         imemidx : IN  std_logic_vector(2 downto 0);
         imemadr : IN  std_logic_vector(7 downto 0);
         imemval : IN  std_logic_vector(31 downto 0);
			ipresent			: in std_logic;
         imemwe : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal pcin : pcin_type;
   signal tagidx : std_logic_vector(2 downto 0) := (others => '0');
   signal tagadr : std_logic_vector(3 downto 0) := (others => '0');
   signal tagval : std_logic_vector(25 downto 10) := (others => '0');
   signal tagwe : std_logic := '0';
   signal imemidx : std_logic_vector(2 downto 0) := (others => '0');
   signal imemadr : std_logic_vector(7 downto 0) := (others => '0');
   signal imemval : std_logic_vector(31 downto 0) := (others => '0');
   signal imemwe : std_logic := '0';
	signal ipresent : std_logic := '0';
 	--Outputs
  signal notrim_o : std_logic_vector(IM_BITS-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: octagon PORT MAP (
          clk => clk,
          pcin => pcin,
          notrim_o => notrim_o,
          tagidx => tagidx,
          tagadr => tagadr,
          tagval => tagval,
          tagwe => tagwe,
          imemidx => imemidx,
          imemadr => imemadr,
          imemval => imemval,
          imemwe => imemwe,
			 ipresent => ipresent
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


      wait;
   end process;

END;
