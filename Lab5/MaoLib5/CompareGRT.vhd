-----------------------------------------------------------------------------
-- Entity:        Mux4to1_4bit
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/17/2015
-- Description:   A generic comparator that checks if an n-bit number ,A is greater than B .
--
-- 
-- Dependencies:
--		None.
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


  entity CompareGRT is
   generic(n : integer := 4);
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            GRT : out STD_LOGIC_VECTOR (n-1 downto 0));
end CompareGRT;

  architecture Behavioral of CompareGRT is

begin
    GRT <= A  when (A > B) else B;

end Behavioral;