----------------------------------------------------------------------------
-- Entity:        OneShot
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:    Produces a one cycle pulse when input goes from low to high
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity OneShot is
  port (D    : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
		  Q    : out STD_LOGIC := '0');
end OneShot;

architecture Behavioral of OneShot is
  --internal signals
   signal Q_int: STD_LOGIC := '0';
	
  begin
  
  DFF: Dff_CE port map
    (D   => D, 
 	  CLK => CLK, 
	  Q   => Q_int);

Q <= ((Not Q_int) and D); 

end Behavioral;
 
