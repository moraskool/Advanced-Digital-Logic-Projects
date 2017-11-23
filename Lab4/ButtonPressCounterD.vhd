----------------------------------------------------------------------------
-- Entity:        Register6
-- Written By:    Morayo Ogunsina
-- Date Created:  10/22/2015
-- Description:    Counts the number of button press.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		OneShot
--    Debouncer
--    Counter_nbit
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity ButtonPressCounterD is
  port   (
          CLK    : in  STD_LOGIC;
		    CLEAR  : in  STD_LOGIC;
		    EN     : in  STD_LOGIC;
		    Qsix   : out STD_LOGIC_VECTOR (15 downto 0));

end ButtonPressCounterD;

architecture Behavioral of ButtonPressCounterD is
    -- declare internal signals
	 
  signal Qint     : STD_LOGIC;
  signal pulse500  : STD_LOGIC;
  signal Q_int6    : STD_LOGIC_VECTOR(15 downto 0);
  signal Q_sht     : STD_LOGIC;
begin
     
	  --components instantiation
			-- oneshot
     	REG6_ONESHT  : OneShot port map (
		      D      =>  Qint,  
			   CLK    =>  CLK,    
			   Q      =>  Q_sht);
				
				--generic counter
		REG6_COUNTER : Counter_nbit generic map(16) port map (
		      EN     =>  Q_sht,  
			   CLK    =>  CLK,     
			   CLR    =>  CLEAR,   
			   Q      =>  Q_int6);
				
	         --debouncer
	   REG_DEB      : Debouncer port map  (
		     D       =>  EN, 
           SAMPLE	 =>  pulse500,	  
			  CLk     =>  CLk,      
			  Q       =>  Qint);
			  
			  --pulse generator
		P500 : PulseGenerator generic map (
			      n        => 32,
		         maxCount => 200000)port map
	           (EN       => '1',
	            CLK      => CLK,
               CLR      => CLEAR,
               PULSE    => pulse500);	
					
	Qsix <= Q_int6;


end Behavioral;

