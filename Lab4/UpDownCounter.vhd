----------------------------------------------------------------------------
-- Entity:        Register7
-- Written By:    Morayo Ogunsina
-- Date Created:  10/22/2015
-- Description:    UP/Down Counter.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		OneShot
--    Debouncer
--    CounterUpDown_nbit
--    PulseGenerator
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;

entity UpDownCounter is
		port (EN    :  in STD_LOGIC ;
		      UP    :  in STD_LOGIC;
		      DOWN  :  in STD_LOGIC;
		      CLK   :  in STD_LOGIC;
				CLR   :  in STD_LOGIC;
			  Qsevn  :  out STD_LOGIC_VECTOR(15 downto 0));
end UpDownCounter;

architecture Behavioral of UpDownCounter is

  -- declare internal signals
  signal D_int     : STD_LOGIC;
  signal Q_int     : STD_LOGIC;
  signal Q_int7    : STD_LOGIC_VECTOR(15 downto 0);
  signal Q_shtUP   : STD_LOGIC;
  signal Q_shtDOWN : STD_LOGIC;
  signal pulse500  : STD_LOGIC;
  signal pulse1000 : STD_LOGIC;
  signal DB_up     : STD_LOGIC;
  signal EN_int    : STD_LOGIC;
  signal DB_down   : STD_LOGIC;
begin
  
  
  
            --OneShot
     	ONESHT_up  : OneShot port map (
		      D      =>  DB_up,  
			   CLK    =>  CLK,
			   Q      =>  Q_shtUP);
				
				--OneShot
	   ONESHT_down  : OneShot port map (
		      D      =>  DB_down, 
			   CLK    =>  CLK, 
			   Q      =>  Q_shtDOWN);		
				
				--generic counter
		REG7_COUNTER : CounterUpDown_nbit generic map(16) port map (
		      EN     =>  '1',
				UP     =>  Q_shtUP,
				DOWN   =>  Q_shtDOWN,
			   CLK    =>  CLK,   
			   CLR    =>  CLR, 
			   Q      =>  Q_int7);
	
	        --Debouncer
	   DEB_up      : Debouncer port map  (
		     D       =>  UP, 
			  SAMPLE  =>  pulse500, 
			  CLK     =>  CLK,   
			  Q       =>  DB_up);
			 
			   --Debouncer
	  DEB_down    : Debouncer port map  (
		     D       =>  DOWN, 
			  SAMPLE  =>  pulse1000, 
			  CLK     =>  CLK,   
			  Q       =>  DB_down);
			  
     	      --pulse generator
	  P500 : PulseGenerator generic map (
			   n        => 32,
			   maxCount => 200000) port map
			
	        (EN       => EN,
	         CLK      => CLK,
            CLR      => CLR,
            PULSE    => pulse500);
      
     	      --pulse generator
	  P1000 : PulseGenerator generic map (
			   n        => 32,
			   maxCount => 104000) port map
	        (EN       => '1',
	         CLK      => CLK,
            CLR      => CLR,
            PULSE    => pulse1000);
				
		Qsevn <= Q_int7;		
					
end Behavioral;

