----------------------------------------------------------------------------
-- Entity:        DFlipFlop with clock enable
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:    A D Flip-Flop device that is enabled synchronously
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFFCLK_ENABLE is
    Port ( D   : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
			  Q   : out STD_LOGIC := '0');
end DFFCLK_ENABLE;

architecture Behavioral of DFFCLK_ENABLE is

begin
    process(CLK) is 
	   begin
		if (CLK'event and CLK='1') then 
			  Q <= D; 
		end if;
	end process;
end Behavioral;

