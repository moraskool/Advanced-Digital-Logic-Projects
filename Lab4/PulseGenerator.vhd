----------------------------------------------------------------------------
-- Entity:        PulseGenerator
-- Written By:    Morayo Ogunsina
-- Date Created:  10/14/2015
-- Description:    Produces a one -cycle pulse every (maxCount +1 )
--                 cycles 
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;

entity PulseGenerator is
   generic (n        : integer := 4
	         maxCount : natural := 9);
   port    (EN       : in  STD_LOGIC;
	         CLK      : in  STD_LOGIC;
            CLR      : in  STD_LOGIC;
            PULSE    : out STD_LOGIC);				)
end PulseGenerator;

architecture Behavioral of PulseGenerator is
-- declare the internal signals
 signal Q_int            : STD_LOGIC;
 signal pulse_out        : STD_LOGIC;
 signal pulse_out_clean  : STD_LOGIC;

 -- instantiate the Counter_nbit
  component Counter_nbit is
      generic (n : integer := 4);
		port (EN    :  in STD_LOGIC;
		      CLK   :  in STD_LOGIC;
				CLR   :  in STD_LOGIC;
				 Q    :  out STD_LOGIC_VECTOR(n-1 downto 0));
end component;
 
 -- instantiate the CompareEQU
 component CompareEQU is
   generic(n : integer := 4);
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            EQU : out STD_LOGIC_VECTOR (n-1 downto 0));
 end component;
 
 -- instantiate a D-Flip flop
 component DFlipFlop is
       port (
		        D   : in STD_LOGIC ;
				  CLK : in STD_LOGIC ;
				  Q   : out STD_LOGIC);
 end component;
 
 begin
   COUNTER   : Counter_nbit generic map (n) port map (
	     EN  => EN,
		  CLK => CLK,
		  CLR => CLR,
		  Q   => Q_int );
	
	COMPEQ    : CompareEQU generic map   (n) port map (
	     A    =>  Q_int ,   
	     B    =>  maxCount,
		  EQU  =>  pulse_out);
		  
	REG_PULSE : DFlipFlop port map(
	     D    => pulse_out, 
		  CLK  => CLK,
		  Q    => pulse_clean);

 PULSE <= pulse_clean;
end Behavioral;

