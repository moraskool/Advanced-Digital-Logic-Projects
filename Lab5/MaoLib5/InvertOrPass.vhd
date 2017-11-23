----------------------------------------------------------------------------
-- Entity:        InvertOrPass
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:   Inverts the a 4 bit binary number .
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity InvertOrPass is
    Port ( B         : in  STD_LOGIC_VECTOR (3 downto 0);
           BXOR      : out  STD_LOGIC_VECTOR (3 downto 0);
           SUBTRACT  : in  STD_LOGIC);
end InvertOrPass;

architecture Behavioral of InvertOrPass is

begin
      BXOR(0)   <=  (B(0))XOR SUBTRACT;
		BXOR(1)   <=  (B(1))XOR SUBTRACT;
		BXOR(2)   <=  (B(2))XOR SUBTRACT;
		BXOR(3)   <=  (B(3))XOR SUBTRACT;
end Behavioral;

