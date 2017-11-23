----------------------------------------------------------------------------
-- Entity:        Register0
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:    Adds or subtracts two 4 bit numbers.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		FullAdder
--    InvertOrPass
--    OverflowDetect
--    RippleCarryAdder_4bit.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
  port (D      : in  STD_LOGIC;
        CLK    : in  STD_LOGIC;
		  LOAD   : in  STD_LOGIC;
		  Qzero  : out STD_LOGIC_VECTOR(15 downto 0):= (OTHERS => '0'));
end ShiftRegister;

architecture Behavioral of ShiftRegister is

  signal Q_int  : STD_LOGIC_VECTOR(15 downto 0):= (OTHERS => '0');
  
 begin
    process (CLK)	
	begin  
	       if(CLK 'event and CLK ='1') then
			    if(LOAD = '1')then
	             Q_int <= D  & Q_int(15 downto 1);	 
			   end if;
	       end if;	 
  end process ;
       Qzero <= Q_int;
end Behavioral;
