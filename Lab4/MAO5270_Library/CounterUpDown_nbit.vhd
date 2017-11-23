----------------------------------------------------------------------------
-- Entity:        Generic n-bit up down counter
-- Written By:    Morayo Ogunsina
-- Date Created:  10/14/2015
-- Description:    Generic n-bit up/down counter with enable and synchronous clear inputs
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;



 entity CounterUpDown_nbit is
      generic (n : integer := 4);
		port (EN    :  in STD_LOGIC;
		      UP    :  in STD_LOGIC;
		      DOWN  :  in STD_LOGIC;
		      CLK   :  in STD_LOGIC;
				CLR   :  in STD_LOGIC;
				 Q    :  out STD_LOGIC_VECTOR(n-1 downto 0):= (OTHERS => '0'));
end CounterUpDown_nbit;

architecture Behavioral of CounterUpDown_nbit is

	  --declare internal signals
    
	 signal Qupdown : STD_LOGIC_VECTOR(n-1 downto 0):= (OTHERS => '0');
  begin 
      process (CLK) is 
	     begin 
		     if (CLK'event and CLK='1') then 
			      if(CLR = '1') then 
				     Qupdown <= (OTHERS => '0'); 
			      elsif (UP = '1' and EN = '1') then
				     Qupdown <= STD_LOGIC_VECTOR(unsigned(Qupdown) + 1);
			      elsif(DOWN = '1' and EN = '1') then
				     Qupdown <= STD_LOGIC_VECTOR(unsigned(Qupdown) - 1);   
			     end if;
		    end if;
		end process;
	Q <= Qupdown; --convert back to standard logic	
end Behavioral;

