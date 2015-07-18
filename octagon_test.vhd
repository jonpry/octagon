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
		wbmoutsigs		: out wbmoutsig_type;
		wbcyc				: in std_logic;
		wback				: in std_logic;
		wbdata			: in std_logic_vector(31 downto 0);
		mcb_cmd			: out std_logic_vector(2 downto 0);
		mcb_bl			: out std_logic_vector(5 downto 0);
		mcb_adr			: out std_logic_vector(29 downto 0);
		mcb_rden			: out std_logic;
		mcb_en			: out std_logic;
		mcb_data			: in std_logic_vector(31 downto 0);
		mcb_empty		: in std_logic;
		mcb_cmd_full	: in std_logic;
		dmcb_cmd			: out std_logic_vector(2 downto 0);
		dmcb_bl			: out std_logic_vector(5 downto 0);
		dmcb_adr			: out std_logic_vector(29 downto 0);
		dmcb_rden		: out std_logic;
		dmcb_en			: out std_logic;
		dmcb_data		: in std_logic_vector(31 downto 0);
		dmcb_empty		: in std_logic;
		dmcb_cmd_full	: in std_logic;
		dmcb_dout		: out std_logic_vector(31 downto 0);
		dmcb_wren		: out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal running : std_logic_vector(7 downto 0) := (others => '0');
	signal int	: std_logic_vector(7 downto 0) := (others => '0');

	signal mcb_data : std_logic_vector(31 downto 0) := (others => '0');
	signal mcb_empty : std_logic := '0';
	signal mcb_cmd_full : std_logic := '0';
	signal dmcb_data : std_logic_vector(31 downto 0) := (others => '0');
	signal dmcb_empty : std_logic := '0';
	signal dmcb_cmd_full : std_logic := '0';
	signal wbcyc : std_logic := '1';
	signal wback : std_logic := '1';
	signal wbdata : std_logic_vector(31 downto 0) := X"00AABB00";
	
 	--Outputs
	signal wbmout : wbmoutsig_type;
	signal mcb_cmd	: std_logic_vector(2 downto 0);
	signal mcb_bl : std_logic_vector(5 downto 0);
	signal mcb_adr	: std_logic_vector(29 downto 0);
	signal mcb_rden : std_logic;
	signal mcb_en	: std_logic;
	signal dmcb_cmd	: std_logic_vector(2 downto 0);
	signal dmcb_bl : std_logic_vector(5 downto 0);
	signal dmcb_adr	: std_logic_vector(29 downto 0);
	signal dmcb_rden : std_logic;
	signal dmcb_en	: std_logic;
	signal dmcb_wren : std_logic;
	signal dmcb_dout : std_logic_vector(31 downto 0);
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	type char_file is file of character; -- one byte each	
	file my_file : char_file;
	constant file_name : string := "/home/jon/mips/main.bin";
	
		-- the data ram
	constant nwords : integer := 2 ** 21;
	type ram_type is array(0 to nwords-1) of std_logic_vector(31 downto 0);
	
	type IMEM_STATE_T is (RESET,WAIT_FOR_REQ,TRANSFER_WRITE,TRANSFER);
	signal state : IMEM_STATE_T := WAIT_FOR_REQ;
	signal dstate : IMEM_STATE_T := WAIT_FOR_REQ;
 
 	signal count : std_logic_vector(6 downto 0);
	signal len : std_logic_vector(5 downto 0);
	signal addr : std_logic_vector(24 downto 0);
	
 	signal dcount : std_logic_vector(6 downto 0);
	signal dlen : std_logic_vector(5 downto 0);
	signal daddr : std_logic_vector(24 downto 0);
	
	--DC data fifo
	type dcram_type is array(0 to 63) of std_logic_vector(31 downto 0);
	signal dcdin : dcram_type := (others => (others => '0'));
	signal dcwraddr : unsigned(5 downto 0) := (others => '0');
	signal dcrdaddr : unsigned(5 downto 0) := (others => '0');
	signal dcfiforden : std_logic := '0';
	signal dcfifoout : std_logic_vector(31 downto 0);
	
	--DC cmd fifo
	type cmdram_type is array(0 to 3) of std_logic_vector(35 downto 0);
	signal cmds : cmdram_type := (others => (others => '0'));
	signal cmdwraddr : unsigned(1 downto 0) := (others => '0');
	signal cmdrdaddr : unsigned(1 downto 0) := (others => '0');
	signal cmdrden : std_logic := '0';
	signal cmdblout : std_logic_vector(5 downto 0);
	signal cmdadrout : std_logic_vector(29 downto 0);	
	
	signal start : std_logic := '0';
	
	--DM pump
	signal index : integer range 0 to 64000;
	signal dmin : std_logic_vector(31 downto 0);
	signal dmwr : std_logic := '0';
	type DCPUMP_STATE_T is (DCPUMP_WAIT, DCPUMP_TRANSFER, DCPUMP_DONE);
	signal dcpump_state : DCPUMP_STATE_T := DCPUMP_WAIT;
	signal pumplen : unsigned(5 downto 0);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: octagon PORT MAP (
          clk => clk,
			 running => running,
			 int => int,
 			 wbmoutsigs => wbmout,
			 wbcyc => wbcyc,
			 wback => wback,
			 wbdata => wbdata,
			 mcb_cmd => mcb_cmd,
			 mcb_bl => mcb_bl,
			 mcb_adr => mcb_adr,
			 mcb_rden => mcb_rden,
			 mcb_en => mcb_en,
			 mcb_data => mcb_data,
			 mcb_empty => mcb_empty,
			 mcb_cmd_full => mcb_cmd_full,
 			 dmcb_cmd => dmcb_cmd,
			 dmcb_bl => dmcb_bl,
			 dmcb_adr => dmcb_adr,
			 dmcb_rden => dmcb_rden,
			 dmcb_wren => dmcb_wren,
			 dmcb_dout => dmcb_dout,
			 dmcb_en => dmcb_en,
			 dmcb_data => dmcb_data,
			 dmcb_empty => dmcb_empty,
			 dmcb_cmd_full => dmcb_cmd_full
 
        );
		  
	--DC Data fifo
	process(clk)
	begin
		if clk='1' and clk'Event then
			if dmcb_wren = '1' then
				dcdin(to_integer(dcwraddr)) <= dmcb_dout;
				dcwraddr <= dcwraddr + 1;
			end if;
			dcfifoout <= dcdin(to_integer(dcrdaddr));
			if dcfiforden = '1' then
				dcrdaddr <= dcrdaddr + 1;
			end if;
		end if;
	end process;
	
	
	--DC Data fifo
	process(clk)
	begin
		if clk='1' and clk'Event then
			if dmcb_en = '1' and dmcb_cmd = "000" then 
				cmds(to_integer(cmdwraddr)) <= dmcb_bl & dmcb_adr;
				cmdwraddr <= cmdwraddr + 1;
			end if;
			cmdblout <= cmds(to_integer(cmdrdaddr))(35 downto 30);
			cmdadrout <= cmds(to_integer(cmdrdaddr))(29 downto 0);
			if cmdrden = '1' then
				cmdrdaddr <= cmdrdaddr + 1;
			end if;
		end if;
	end process;
	
	--DC write machine
	process(clk,index)
		variable dm : ram_type := (others => (others => '0'));
		variable next_count : std_logic_vector(6 downto 0);
		variable slice_count : std_logic_vector(5 downto 0);
		
		variable I : integer;
	   variable vec : std_logic_vector(15 downto 0);
		variable my_char : character;
		variable dmemval : std_logic_vector(31 downto 0);
	begin
	   if start = '0' then
			start <= '1';
			I := 0;	
		file_open(my_file, file_name, read_mode);		
		while not ENDFILE(my_file) loop
			vec := std_logic_vector(to_unsigned(I,vec'length));
			read(my_file, my_char);
			dmemval(7 downto 0) := std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			dmemval(15 downto 8) := std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			dmemval(23 downto 16) := std_logic_vector(to_unsigned(character'pos(my_char),8));
			read(my_file, my_char);
			dmemval(31 downto 24) := std_logic_vector(to_unsigned(character'pos(my_char),8));
--			wait for clk_period;
			
			dm(I) := dmemval;
			I := I + 1;
		end loop;
		file_close(my_file);

			
		elsif clk='1' and clk'Event then
			if dcpump_state = DCPUMP_WAIT then
				if cmdwraddr /= cmdrdaddr then
					dcpump_state <= DCPUMP_TRANSFER;
					dcfiforden <= '1';
					pumplen <= (others => '0');
				end if;
			elsif dcpump_state = DCPUMP_TRANSFER then
				pumplen <= pumplen + 1;
				if pumplen = unsigned(cmdblout)  then
					dcfiforden <= '0';
					cmdrden <= '1';
					dcpump_state <= DCPUMP_DONE;
				end if;
				if pumplen > 0 then
					dm( to_integer(unsigned(cmdadrout(29 downto 2)) + pumplen - 1)) := dcfifoout;
				end if;
			else
				dm( to_integer(unsigned(cmdadrout(29 downto 2)) + pumplen - 1)) := dcfifoout;
				cmdrden <= '0';
				dcpump_state <= DCPUMP_WAIT;
			end if;
		end if;
		if clk='1' and clk'Event then
			if state = WAIT_FOR_REQ then
				mcb_empty <= '1' after 100 ps;
				if mcb_en = '1' then
					state <= TRANSFER after 100 ps;
					len <= mcb_bl after 100 ps;
					addr <= mcb_adr(26 downto 2) after 100 ps;
					count <= "0000000" after 100 ps;
				end if;
			else
				next_count := std_logic_vector(unsigned(count) + 1);
				slice_count := count(6 downto 1);
				if unsigned(count(6 downto 1)) <= unsigned(len) then
						mcb_data <= dm(to_integer(unsigned(addr)+unsigned(slice_count))) after 100 ps;
						mcb_empty <= '0' after 100 ps;
					if mcb_rden='1' then
						if unsigned(count(5 downto 1)) < unsigned(len) then
							mcb_empty <= not count(0);
							mcb_data <= dm(to_integer(unsigned(addr)+unsigned(slice_count)+1)) after 100 ps;
						else
							mcb_empty <= '1' after 100 ps;
							state <= WAIT_FOR_REQ after 100 ps;
						end if;
						count <= next_count;
					end if;
				else
					if unsigned(count(6 downto 1)) <= (unsigned(len)+1) and count(0) = '0' then
							mcb_empty <= count(0);
							mcb_data <= dm(to_integer(unsigned(addr)+unsigned(slice_count))) after 100 ps;
					else
						mcb_empty <= '1' after 100 ps;
						state <= WAIT_FOR_REQ after 100 ps;
					end if;
				end if;
			end if;
		end if;
		if clk='1' and clk'Event then
			if dstate = WAIT_FOR_REQ then
				dmcb_empty <= '1' after 100 ps;
				if dmcb_en = '1' and dmcb_cmd = "001" then
					dstate <= TRANSFER after 100 ps;
					dlen <= dmcb_bl after 100 ps;
					daddr <= dmcb_adr(26 downto 2) after 100 ps;
					dcount <= "0000000" after 100 ps;
				end if;
			else
				next_count := std_logic_vector(unsigned(dcount) + 1);
				slice_count := dcount(6 downto 1);
				if unsigned(dcount(6 downto 1)) <= unsigned(dlen) then
						dmcb_data <= dm(to_integer(unsigned(daddr)+unsigned(slice_count))) after 100 ps;
						dmcb_empty <= '0' after 100 ps;
					if dmcb_rden='1' then
						if unsigned(dcount(5 downto 1)) < unsigned(dlen) then
							dmcb_empty <= not dcount(0);
							dmcb_data <= dm(to_integer(unsigned(daddr)+unsigned(slice_count)+1)) after 100 ps;
						else
							dmcb_empty <= '1' after 100 ps;
							dstate <= WAIT_FOR_REQ after 100 ps;
						end if;
						dcount <= next_count;
					end if;
				else
					if unsigned(dcount(6 downto 1)) <= (unsigned(dlen)+1) and dcount(0) = '0' then
							dmcb_empty <= dcount(0);
							dmcb_data <= dm(to_integer(unsigned(daddr)+unsigned(slice_count))) after 100 ps;
					else
						dmcb_empty <= '1' after 100 ps;
						dstate <= WAIT_FOR_REQ after 100 ps;
					end if;
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
	variable dmemval : std_logic_vector(31 downto 0);
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		running <= (others => '0');
		dmwr <= '0';

      wait for clk_period*10;
				
		I := 0;
		while I < 128 loop
			vec := std_logic_vector(to_unsigned(I,vec'length));
			wait for clk_period;
			I := I + 1;
		end loop;
  

		wait for clk_period;

		wait for clk_period;
		
      dmwr <= '0';
		running <= "00000001";
		
		wait for 7 us;
		
		--TODO: interrupts need some kind of latching system
		--int <= X"01";
		
		wait for clk_period * 100;
		
		int <= X"00";
				
		wait;

   end process;

END;
