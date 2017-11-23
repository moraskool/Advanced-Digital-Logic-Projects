
-- Entity:        Debouncer
-- Written By:    Morayo Ogunsina
-- Date Created:  10/14/2015
-- Description:    Removes rapid transitions,such as due to button/switch 
--                 bounce,so that mechanical transition results in one 
--                 signal transition.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debouncer is
     port (D      : in STD_LOGIC;
	        SAMPLE : in STD_LOGIC;
			  CLK    : in STD_LOGIC;
			  Q      : out STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is
  -- declare internal signals
 signal Q_int : STD_LOGIC_VECTOR(2 downto 0); 

begin

	process (CLK) is 
		begin
		
			if (CLK'event and CLK='1') then 
				if (SAMPLE = '1') then
					Q_int(2) <= Q_int(1);
					Q_int(1) <= Q_int(0);
					Q_int(0) <= D;
				 end if;
			end if;		
		end process;
		Q <=  Q_int(1) and Q_int(2);
end Behavioral;

