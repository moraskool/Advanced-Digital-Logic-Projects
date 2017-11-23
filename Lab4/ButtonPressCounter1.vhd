----------------------------------------------------------------------------
-- Entity:        Register4
-- Written By:    Morayo Ogunsina
-- Date Created:  10/22/2015
-- Description:   Counts the number of pulses.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		Debouncer
--    Counter_nbit
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity ButtonPressCounter1 is
    port (
          CLK    : in  STD_LOGIC;
		    CLEAR  : in  STD_LOGIC;
		    EN     : in  STD_LOGIC;
		    Qfive  : out STD_LOGIC_VECTOR (15 downto 0));

end ButtonPressCounter1;

architecture Behavioral of ButtonPressCounter1 is

 -- declare internal signals
  signal D_out    : STD_LOGIC;
  signal Q_sht    : STD_LOGIC;
  signal Q_int5   : STD_LOGIC_VECTOR(15 downto 0);


begin   
       DFFS:  DFFC port map (
				D   => EN,
				CLK => CLK,
				Q   => D_out);
         
             --OneShot
       REG5_ONESHT  : OneShot port map (
		      D      =>  D_out,  
			   CLK    =>  CLK,    
			   Q      =>  Q_sht);
			  
				--generic counter
		REG5_COUNTER : Counter_nbit generic map(16) port map (
		      EN     =>  Q_sht, 
			   CLK    =>  CLK, 
			   CLR    =>  CLEAR, 
			   Q      =>  Q_int5);			
	 Qfive <= Q_int5;

end Behavioral;
