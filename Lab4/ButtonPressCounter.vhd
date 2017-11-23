----------------------------------------------------------------------------
-- Entity:        Register5
-- Written By:    Morayo Ogunsina
-- Date Created:  10/22/2015
-- Description:   Counts the number of time the button bounces.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		Counter_nbit
--    OneShot
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;

entity ButtonPressCounter is
    port (
          CLK    : in  STD_LOGIC;
		    CLEAR  : in  STD_LOGIC;
		    EN     : in  STD_LOGIC;
		    Qfour  : out STD_LOGIC_VECTOR(15 downto 0):= (OTHERS => '0'));

end ButtonPressCounter;

architecture Behavioral of ButtonPressCounter is

 -- declare internal signals
  signal Q_int4  : STD_LOGIC_VECTOR(15 downto 0):= (OTHERS => '0');
 
  begin

    --components instantiation
				
		REG5_COUNTER : Counter_nbit generic map(16) port map (
		      EN     =>  EN, 
			   CLK    =>  CLK,   
			   CLR    =>  CLEAR, 
			   Q      =>  Q_int4);
	  
	Qfour <= Q_int4;

end Behavioral;
