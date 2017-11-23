----------------------------------------------------------------------------
-- Entity:        Mux4to1_4bit
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/17/2015
-- Description:   A generic comparator that checks if two n-bit numbers ,A and B are equal.
--
-- 
-- Dependencies:
--		None.
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


  entity CompareEQU is
   generic(n : integer := 4);
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            EQU : out STD_LOGIC_VECTOR (n-1 downto 0));
end CompareEQU;

architecture Behavioral of CompareEQU is

begin
    EQU <= A  when (A = B) else B;

end Behavioral;

