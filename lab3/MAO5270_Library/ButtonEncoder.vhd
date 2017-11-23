----------------------------------------------------------------------------
-- Entity:        ButtonEncoder
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/17/2015
-- Description:   Button Selector for MUX4to1_4bit.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;
use MAO5270_Library.MAO5270_Components.all;


entity ButtonEncoder is
    Port ( BTNL : in  STD_LOGIC;
           BTNR : in  STD_LOGIC;
           BTNU : in  STD_LOGIC;
			  BTND : in  STD_LOGIC;
			  BTNC : in  STD_LOGIC;
           SEL  : out STD_LOGIC_VECTOR (2 downto 0));
end ButtonEncoder;

architecture Structural of ButtonEncoder is

   signal NoButton : STD_LOGIC ;
	
begin
   
	 SEL <= "000" when (BTNL = '1' and BTNR = '0' and BTNU = '0'and BTND = '0'and BTNC = '0' ) else
	        "001" when (BTNL = '0' and BTNR = '1' and BTNU = '0'and BTND = '0'and BTNC = '0' ) else
			  "010" when (BTNL = '0' and BTNR = '0' and BTNU = '1'and BTND = '0'and BTNC = '0' ) else
			  "011" when (BTNL = '0' and BTNR = '0' and BTNU = '0'and BTND = '1'and BTNC = '0' ) else
			  "101" when (BTNL = '0' and BTNR = '0' and BTNU = '0'and BTND = '0'and BTNC = '1' ) else
			  "100" when (NoButton = '1') else
			  "111" ;
    
	   NoButton <= (Not(BTNL) AND Not(BTNR)AND Not(BTNU)AND Not(BTNC));
	 
end Structural;

