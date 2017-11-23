----------------------------------------------------------------------------
-- Entity:        PulseGenerator
-- Written By:    Morayo Ogunsina
-- Date Created:  10/14/2015
-- Description:    Produces a one -cycle pulse every (maxCount +1 )
--                 cycles 
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity PulseGenerator is
   generic (n        : integer := 4;
	         maxCount : integer := 15);
   port    (EN       : in  STD_LOGIC;
	         CLK      : in  STD_LOGIC;
            CLR      : in  STD_LOGIC;
            PULSE    : out STD_LOGIC);	
end PulseGenerator;

 architecture Behavioral of PulseGenerator is
   -- declare the internal signals
  signal CLR_int         : STD_LOGIC;
  signal Count           : STD_LOGIC_VECTOR(n-1 downto 0):= (OTHERS => '0');
  signal pulse_out       : STD_LOGIC;

 
   begin	
	    process (CLK) is 
	      begin 
	
		     if (CLK'event and CLK='1') then 
			    if(CLR_int = '1') then 
				    count <= (others => '0');			
			    elsif (EN = '1') then
				    count <= STD_LOGIC_VECTOR(unsigned(count)+1); 			
			    end if;
		     end if;
		
	    end process;
		
	pulse_out <= '1'	when (to_integer(unsigned(count)) = maxCount) else '0';	
	CLR_int   <= (pulse_out) or (CLR);	
	PULSE     <= pulse_out; 
	
end Behavioral;