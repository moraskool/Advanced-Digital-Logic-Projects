----------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Entity:        OverflowDetect
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:   Detects if a the result of A+B or A-B  can be represented in SUM without any spill over.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity OverflowDetect is
    Port ( A_MSB     : in  STD_LOGIC;
           B_MSB     : in  STD_LOGIC;
           SUM_MSB   : in  STD_LOGIC;
           SUBTRACT  : in  STD_LOGIC;
           OVERFLOW  : out STD_LOGIC);
end OverflowDetect;

architecture Behavioral of OverflowDetect is

begin

  --overflow <= '0';
   overflow <= (NOT SUBTRACT AND NOT A_MSB AND NOT B_MSB AND SUM_MSB)OR (NOT SUBTRACT AND A_MSB AND B_MSB AND NOT SUM_MSB)OR(SUBTRACT AND NOT A_MSB AND B_MSB AND SUM_MSB)OR (SUBTRACT AND A_MSB AND NOT B_MSB AND NOT SUM_MSB);
end Behavioral;

