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


 entity ButtonEncoder is
    Port ( BTNU : in  STD_LOGIC;
           BTNC : in  STD_LOGIC;
           BTND : in  STD_LOGIC;
           SEL  : out  STD_LOGIC_VECTOR (1 downto 0));
 end ButtonEncoder;

 architecture Structural of ButtonEncoder is

begin
   
	 SEL <= "00" when (BTNU = '1' and BTNC = '0' and BTND = '0') else
	        "01" when (BTNU = '0' and BTNC = '1' and BTND = '0') else
			  "10" when (BTNU = '0' and BTNC = '0' and BTND = '1') else
			  "11" ;

end Structural;

