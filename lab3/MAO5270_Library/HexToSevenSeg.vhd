----------------------------------------------------------------------------
-- Entity:        HexToSevenSeg
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/17/2015
-- Description:    Take in a 4 bit binary number and convert to.>
--                 a seven bit decoded output to be displayed on 
--                 a seven segment display.
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity HexToSevenSeg is
    Port ( HEX     : in  STD_LOGIC_VECTOR (3 downto 0);
           SEGMENT : out  STD_LOGIC_VECTOR (0 to 6));
end HexToSevenSeg;

architecture Structural of HexToSevenSeg is

begin
  
   with HEX select 
	    SEGMENT <= "1000000" when "0000", --0
		            "1111001" when "0001", --1
						"0100100" when "0010", --2
						"0110000" when "0011", --3
						"0011001" when "0100", --4
						"0010010" when "0101", --5
						"0000010" when "0110", --6
						"1111000" when "0111", --7
						"0000000" when "1000", --8
						"0010000" when "1001", --9
						"0001000" when "1010", --10
						"0000011" when "1011", --11
						"1000110" when "1100", --12
						"0100001" when "1101", --13
						"0000110" when "1110", --14
						"0001110" when "1111", --15
						"1111111" when others; 

 end Structural;

