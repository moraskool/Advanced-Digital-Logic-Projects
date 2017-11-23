
----------------------------------------------------------------------------
-- Entity:        AVG_4
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/30/2015
-- Description:   Finds the average of four4-bit numbers.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity AVG_4 is 
    Port ( A_add   : in   STD_LOGIC_VECTOR (3 downto 0);
           B_add   : in   STD_LOGIC_VECTOR (3 downto 0);
			  C_add   : in   STD_LOGIC_VECTOR (3 downto 0);
			  D_add   : in   STD_LOGIC_VECTOR (3 downto 0);
           AVRG    : out  STD_LOGIC_VECTOR (3 downto 0));
end AVG_4;

architecture Behavioral of AVG_4 is
    

	  -- declare the internal signals
 signal sum1      : STD_LOGIC_VECTOR(3 downto 0);
 signal Cout      : STD_LOGIC_VECTOR(3 downto 0);
 signal sum2      : STD_LOGIC_VECTOR(3 downto 0);
 signal SUMTotal  : STD_LOGIC_VECTOR(3 downto 0);


begin
	  
	 Cout(0)<= '0';
	  
   RCAD1 : RippleCarryAdder_4bit generic map(4) port map 
	      (  A      => A_add,
		      B      => B_add,
		      C_in   => Cout(0),
			   C_out  => Cout(1),
				SUM    => Sum1);
			  
	 RCAD2 :  RippleCarryAdder_4bit generic map(4) port map 
	      ( A      => C_add,
			  B      => D_add,
			  C_in   => Cout(1),
      	  C_out  => Cout(2),
			  SUM    => Sum2);
	
    RCADF :  RippleCarryAdder_4bit generic map(4) port map 
	      ( A      => sum1(3 downto 0),
			  B      => sum2(3 downto 0),
			  C_in   => Cout(2),
			  C_out  => Cout(3),
			  SUM    => SUMTotal);
			  
			    
	AVRG <=  SUMTotal(1 downto 0) & SUMTotal(3 downto 2);
end Behavioral;

