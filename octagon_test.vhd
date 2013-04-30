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
		dtagwe			: in std_logic;
		dmemidx			: in std_logic_vector(2 downto 0);
		dmemadr			: in std_logic_vector(7 downto 0);
		dmemval			: in std_logic_vector(31 downto 0);
		dmemwe			: in std_logic;		
		mcb_cmd			: out std_logic_vector(2 downto 0);
		mcb_bl			: out std_logic_vector(5 downto 0);
		mcb_adr			: out std_logic_vector(29 downto 0);
		mcb_rden			: out std_logic;
		mcb_en			: out std_logic;
		mcb_data			: in std_logic_vector(31 downto 0);
		mcb_empty		: in std_logic;
		mcb_cmd_full	: in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal running : std_logic_vector(7 downto 0) := (others => '0');
	signal int	: std_logic_vector(7 downto 0) := (others => '0');
   signal tagidx : std_logic_vector(2 downto 0) := (others => '0');
   signal tagadr : std_logic_vector(3 downto 0) := (others => '0');
   signal tagval : std_logic_vector(25 downto 10) := (others => '0');
   signal dtagwe : std_logic := '0';
   signal dmemidx : std_logic_vector(2 downto 0) := (others => '0');
   signal dmemadr : std_logic_vector(7 downto 0) := (others => '0');
   signal dmemval : std_logic_vector(31 downto 0) := (others => '0');
   signal dmemwe : std_logic := '0';
	signal mcb_data : std_logic_vector(31 downto 0) := (others => '0');
	signal mcb_empty : std_logic := '0';
	signal mcb_cmd_full : std_logic := '0';
	
 	--Outputs
	signal notrim_o : std_logic_vector(20 downto 0);
	signal wbmout : wbmout_type;
	signal mcb_cmd	: std_logic_vector(2 downto 0);
	signal mcb_bl : std_logic_vector(5 downto 0);
	signal mcb_adr	: std_logic_vector(29 downto 0);
	signal mcb_rden : std_logic;
	signal mcb_en	: std_logic;
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	type char_file is file of character; -- one byte each	
	file my_file : char_file;
	constant file_name : string := "/home/jon/mips/main.bin";
	
		-- the data ram
	constant nwords : integer := 2 ** 14;
	type ram_type is array(0 to nwords-1) of std_logic_vector(31 downto 0);
	signal dm : ram_type := (others => (others => '0'));
	
	type IMEM_STATE_T is (RESET,WAIT_FOR_REQ,TRANSFER_WRITE,TRANSFER);
	signal state : IMEM_STATE_T := WAIT_FOR_REQ;
 
 	signal count : std_logic_vector(5 downto 0);
	signal len : std_logic_vector(5 downto 0);
	signal addr : std_logic_vector(24 downto 0);
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
          dtagwe => dtagwe,
          dmemidx => dmemidx,
          dmemadr => dmemadr,
          dmemval => dmemval,
          dmemwe => dmemwe,
			 wbmout => wbmout,
			 mcb_cmd => mcb_cmd,
			 mcb_bl => mcb_bl,
			 mcb_adr => mcb_adr,
			 mcb_rden => mcb_rden,
			 mcb_en => mcb_en,
			 mcb_data => mcb_data,
			 mcb_empty => mcb_empty,
			 mcb_cmd_full => mcb_cmd_full
        );
		  
	process(clk)
	begin
		if clk='1' and clk'Event then
			if state = WAIT_FOR_REQ then
				mcb_empty <= '1' after 100 ps;
				if mcb_en = '1' then
					state <= TRANSFER after 100 ps;
					len <= mcb_bl after 100 ps;
					addr <= mcb_adr(26 downto 2) after 100 ps;
					count <= "000000" after 100 ps;
				end if;
			else
				if count <= len then
						mcb_data <= dm(to_integer(unsigned(addr)+unsigned(count))) after 100 ps;
						mcb_empty <= '0' after 100 ps;
					if mcb_rden='1' then
						if count < len then
							mcb_data <= dm(to_integer(unsigned(addr)+unsigned(count)+1)) after 100 ps;
						else
							mcb_empty <= '1' after 100 ps;
							state <= WAIT_FOR_REQ after 100 ps;
						end if;
						count <= std_logic_vector(unsigned(count) + 1) after 100 ps;
					end if;
				else
					mcb_empty <= '1' after 100 ps;
					state <= WAIT_FOR_REQ after 100 ps;
				end if;
			end if;
		end if;
	end process;  

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
		dtagwe <= '0';

      wait for clk_period*10;
				
		I := 0;
		while I < 128 loop
			dtagwe <= '1';
			vec := std_logic_vector(to_unsigned(I,vec'length));
			tagidx <= vec(6 downto 4);
			tagadr <= vec(3 downto 0);
			tagval <= X"00" & vec(11 downto 4);

			wait for clk_period;
			I := I + 1;
		end loop;
  
		dtagwe <= '0';

		wait for clk_period;

		I := 0;	
		file_open(my_file, file_name, read_mode);		
		while not ENDFILE(my_file) loop
			dmemwe <= '1';
			vec := std_logic_vector(to_unsigned(I,vec'length));
			dmemadr <= vec(7 downto 0);
			dmemidx <= vec(10 downto 8);
			read(my_file, my_char);
			dmemval(7 downto 0) <= std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			dmemval(15 downto 8) <= std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			dmemval(23 downto 16) <= std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			dmemval(31 downto 24) <= std_logic_vector(to_unsigned(character'pos(my_char),8));
			wait for clk_period;
			
			dm(i) <= dmemval;
			I := I + 1;
		end loop;
		file_close(my_file);
		dmemwe <= '0';
		
		wait for clk_period;
		
      
		running <= "00000001";
		
		wait for 7 us;
		
		--TODO: interrupts need some kind of latching system
		int <= X"01";
		
		wait for clk_period * 10;
		
		int <= X"00";
				
		wait;

   end process;

END;
