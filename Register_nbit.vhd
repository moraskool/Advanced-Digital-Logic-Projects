----------------------------------------------------------------------------
-- Entity:        Generic n-bit register
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:    An edge sensitive bit storage device that is enabled synchronously
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_nbit is
      generic(n : integer := 8);   -- NUMBER OF STAGES
		Port (D      :    in   STD_LOGIC_VECTOR (n-1 downto 0):= (OTHERS => '0');
		      LOAD   :    in   STD_LOGIC;
		      CLK    :    in   STD_LOGIC;
				CLR    :    in   STD_LOGIC;
				Q      :    out  STD_LOGIC_VECTOR(n-1 downto 0) := (OTHERS => '0'));
end Register_nbit;

architecture Behavioral of Register_nbit is
  begin
    process (CLK) is  
 	 begin  
 		if (CLK'event and CLK='1') then  
 			if(CLR = '1') then  
 				Q <= (others => '0'); 
 			elsif (LOAD = '1') then 
 				Q <= D; 
 			end if; 
 	 	end if; 
	end process; 

	 
end Behavioral;

