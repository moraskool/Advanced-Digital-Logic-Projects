----------------------------------------------------------------------------
-- Entity:        <FullAdder_4Bit>
-- Written By:    <Abdallah Abdallah>
-- Date Created:  <September 20, 2017>
-- Description:   < 4 bit FullAdder using For-Generate Statement >
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		<List entities, one per line.  Type (none) if none are required.>
----------------------------------------------------------------------------


----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all; 


----------------------------------------------------------
---------- For VIVADO simulation
--library UNISIM;
--use UNISIM.VComponents.all;

---------------------------------------
entity FullAdder_4Bit is
Generic (AdderSize :integer :=4);
port (
        A : in STD_LOGIC_VECTOR (AdderSize-1 downto 0);
		B : in STD_LOGIC_VECTOR(AdderSize-1 downto 0);
		CIN : in STD_LOGIC;
		COUT : out STD_LOGIC; 
		EEEE : out STD_LOGIC_VECTOR(AdderSize-1 downto 0));
end FullAdder_4Bit;

ARCHITECTURE arch1 OF FullAdder_4Bit IS 
signal C : STD_LOGIC_VECTOR(AdderSize downto 0);
  signal tmp: std_logic_vector(3 downto 0);  

begin
	C(0) <= CIN;
	COUT <= C(AdderSize);
	LOOP_ADD : for I in 0 to 3 generate
		EEEE(I)  <= A(I) xor B(I) xor C(I);
		C(I + 1) <= (A(I) and B(I)) or (A(I) and C(I)) or (B(I) and C(I));
	end generate;
 
-- EEEE <= A + B;
-- COUT <= CIN;
 
--   tmp <= conv_std_logic_vector(                
--    (conv_integer(A) +   
--               conv_integer(B) +  
--               conv_integer(CIN)),9);  
--   EEEE <= tmp(7 downto 0);  
--   COUT <= tmp(8);
 
 
 

END arch1;