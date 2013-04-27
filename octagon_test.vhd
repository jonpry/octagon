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
USE ieee.numeric_std.ALL;

use work.octagon_types.all;
 
ENTITY octagon_test IS
END octagon_test;
 
ARCHITECTURE behavior OF octagon_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT octagon
    PORT(
		clk 				: in  std_logic;
		running 			: in std_logic_vector(7 downto 0);
		int 				: in std_logic_vector(7 downto 0);
		notrim_o 		: out std_logic_vector(20 downto 0);
		wbmout			: out wbmout_type;
		tagidx			: in std_logic_vector(2 downto 0);
		tagadr			: in std_logic_vector(3 downto 0);
		tagval			: in std_logic_vector(IM_BITS-1 downto 10);
		itagwe			: in std_logic;
		imemidx			: in std_logic_vector(2 downto 0);
		imemadr			: in std_logic_vector(7 downto 0);
		imemval			: in std_logic_vector(31 downto 0);
		imemwe			: in std_logic;
		dtagwe			: in std_logic;
		dmemidx			: in std_logic_vector(2 downto 0);
		dmemadr			: in std_logic_vector(7 downto 0);
		dmemval			: in std_logic_vector(31 downto 0);
		dmemwe			: in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal running : std_logic_vector(7 downto 0) := (others => '0');
	signal int	: std_logic_vector(7 downto 0) := (others => '0');
   signal tagidx : std_logic_vector(2 downto 0) := (others => '0');
   signal tagadr : std_logic_vector(3 downto 0) := (others => '0');
   signal tagval : std_logic_vector(25 downto 10) := (others => '0');
   signal itagwe : std_logic := '0';
   signal dtagwe : std_logic := '0';
   signal imemidx : std_logic_vector(2 downto 0) := (others => '0');
   signal imemadr : std_logic_vector(7 downto 0) := (others => '0');
   signal imemval : std_logic_vector(31 downto 0) := (others => '0');
   signal imemwe : std_logic := '0';
   signal dmemidx : std_logic_vector(2 downto 0) := (others => '0');
   signal dmemadr : std_logic_vector(7 downto 0) := (others => '0');
   signal dmemval : std_logic_vector(31 downto 0) := (others => '0');
   signal dmemwe : std_logic := '0';

 	--Outputs
	signal notrim_o : std_logic_vector(20 downto 0);
	signal wbmout : wbmout_type;
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	type char_file is file of character; -- one byte each	
	file my_file : char_file;
	constant file_name : string := "/home/jon/mips/main.bin";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: octagon PORT MAP (
          clk => clk,
			 running => running,
			 int => int,
          notrim_o => notrim_o,
          tagidx => tagidx,
          tagadr => tagadr,
          tagval => tagval,
          itagwe => itagwe,
          dtagwe => dtagwe,
          imemidx => imemidx,
          imemadr => imemadr,
          imemval => imemval,
          imemwe => imemwe,
          dmemidx => imemidx,
          dmemadr => imemadr,
          dmemval => imemval,
          dmemwe => imemwe,
			 wbmout => wbmout
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
	variable I : integer range 0 to 64000;
	variable vec : std_logic_vector(15 downto 0);
	variable my_char : character;
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		running <= (others => '0');
		itagwe <= '0';
		dtagwe <= '0';

      wait for clk_period*10;
		
		I := 0;
		while I < 128 loop
			itagwe <= '1';
			vec := std_logic_vector(to_unsigned(I,vec'length));
			tagidx <= vec(6 downto 4);
			tagadr <= vec(3 downto 0);
			tagval <= X"00" & vec(11 downto 4);

			dtagwe <= '1';			
			wait for clk_period;
			I := I + 1;
		end loop;
  
		itagwe <= '0';
		dtagwe <= '0';

		wait for clk_period;

		I := 0;	
		file_open(my_file, file_name, read_mode);		
		while not ENDFILE(my_file) loop
			imemwe <= '1';
			vec := std_logic_vector(to_unsigned(I,vec'length));
			imemadr <= vec(7 downto 0);
			imemidx <= vec(10 downto 8);
			read(my_file, my_char);
			imemval(7 downto 0) <= std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			imemval(15 downto 8) <= std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			imemval(23 downto 16) <= std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			imemval(31 downto 24) <= std_logic_vector(to_unsigned(character'pos(my_char),8));
			wait for clk_period;
			I := I + 1;
		end loop;
		file_close(my_file);
		imemwe <= '0';
		
		wait for clk_period;
		
      
		running <= "00000001";
				
		wait;

   end process;

END;
