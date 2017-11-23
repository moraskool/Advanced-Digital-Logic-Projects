----------------------------------------------------------------------------
-- Entity:        Generic n-bit counter
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:   A counter that counts up per buton press
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity Counter_nbit is
      generic (n : integer := 8);
		port (EN    :  in STD_LOGIC;
		      CLK   :  in STD_LOGIC;
				CLR   :  in STD_LOGIC;
				 Q    :  out STD_LOGIC_VECTOR(n-1 downto 0));
end Counter_nbit;

architecture Behavioral of Counter_nbit is

     --declare internal signals
   signal Q_int  : STD_LOGIC_VECTOR(n-1 downto 0):=(others => '0');
	
 	begin
	  process (CLK) 
	
	   begin 
	
--		if (CLK'event and CLK='1') then 
--			if(CLR = '1') then 
--				Q_int_counter <= 0;
--				Q <= (others => '0');
--			elsif (EN = '1') then
--				Q_int_counter <= Q_int_counter + 1;
--				Q <= STD_LOGIC_VECTOR(to_unsigned((Q_int_counter),Q'length)); 
--			end if;
--		end if;
		
		if (CLK'event and CLK='1') then 
			if(CLR = '1') then 
				Q_int <= (others => '0');
			elsif (EN = '1') then
				Q_int <= STD_LOGIC_VECTOR(unsigned(Q_int) + 1);
			end if;
		end if;
	end process;
	Q <= Q_int;
end Behavioral;

