----------------------------------------------------------------------------
-- Entity:        Register1
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:    Adds or subtracts two 4 bit numbers.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		FullAdder
--    InvertOrPass
--    OverflowDetect
--    RippleCarryAdder_4bit.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;

entity Clock_16hz_Counter is 
  port (
         CLR  : in STD_LOGIC;
			CLK  : in STD_LOGIC;
			Qone : out STD_LOGIC_VECTOR(15 downto 0));
end Clock_16hz_Counter;

architecture Behavioral of Clock_16hz_Counter is
   -- internal signals

  signal Q_int1      : STD_LOGIC_VECTOR(15 downto 0); 
  signal pulse16     : STD_LOGIC;
 begin   
  
       
        --instantiate the Counter_nbit
     FREECOUNTER16 : Counter_nbit generic map(16) port map    
		    ( EN     =>  pulse16, 
			   CLK    =>  CLK, 
			   CLR    =>  CLR, 
			   Q      =>  Q_int1);
			
     P50M : PulseGenerator generic map (32,2) port map
	        (EN       => '1',
	         CLK      => CLK,
            CLR      => CLR,
            PULSE    => pulse16);			
      Qone <= Q_int1;
   
end Behavioral;

