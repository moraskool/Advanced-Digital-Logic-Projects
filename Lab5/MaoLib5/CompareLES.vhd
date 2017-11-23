----------------------------------------------------------------------------
-- Entity:        Generic Comparator for Less Than.
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


  entity CompareLES is
   generic(n : integer := 4);
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            LES : out STD_LOGIC_VECTOR (n-1 downto 0));
end CompareLES;

  architecture Behavioral of CompareLES is

begin
    LES <= A  when (A < B) else B;
	            

end Behavioral;