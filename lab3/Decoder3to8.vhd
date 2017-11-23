----------------------------------------------------------------------------
-- Entity:        3 To 8 decoder with Enable input.
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/17/2015
-- Description:   A generic comparator that checks if an n-bit number ,A is less than B .
--
-- 
-- Dependencies:
--		None.
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decoder3to8 is
     Port ( X    : in  STD_LOGIC_VECTOR (2 downto 0);
            EN   : in  STD_LOGIC;
            YD   : out STD_LOGIC_VECTOR (7 downto 0));
 end Decoder3to8;

architecture Dataflow of Decoder3to8 is
    begin
	 
    YD <= "11111110" when (X= "000" AND EN = '1') else
	       "11111101" when (X= "001" AND EN = '1') else
			 "11111011" when (X= "010" AND EN = '1') else
			 "11110111" when (X= "011" AND EN = '1') else
			 "11101111" when (X= "100" AND EN = '1') else
			 "11011111" when (X= "101" AND EN = '1') else
			 "10111111" when (X= "110" AND EN = '1') else
			 "01111111" when (X= "111" AND EN = '1') else
          "11111111" when (EN = '0');
			 
end Dataflow;

