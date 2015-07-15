----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:22 04/23/2013 
-- Design Name: 
-- Module Name:    octagon - Behavioral 
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

entity octagontest is
	Port ( 
		clk 				: in  std_logic;
      icin :  in icfetchin_type;
		mcb_data			: in std_logic_vector(31 downto 0);
		mcb_empty		: in std_logic;
		mcb_cmd_full	: in std_logic;
		restarted : in std_logic_vector(7 downto 0);
		ictlout : out ictlout_type;
		instr : out std_logic_vector(31 downto 0)
	);
end octagontest;

architecture Behavioral of octagontest is

signal icout : icfetchout_type;
signal ictlin : ictlin_type;
signal imuxout : icmuxout_type;


begin

instr <= imuxout.instr;

ictlin.mcb_data <= mcb_data;
ictlin.mcb_empty <= mcb_empty;
ictlin.mcb_cmd_full <= mcb_cmd_full;
ictlin.restarted <= restarted;
ictlin.ownst <= icout.ownst;

ic_fetch : entity work.ic_fetch port map(clk,icin,icout);	--2
ic_mux : entity work.ic_mux port map(clk,icout,imuxout);		--3
icontrol : entity work.icontrol port map(clk,imuxout,ictlin,ictlout); --4

end Behavioral;

