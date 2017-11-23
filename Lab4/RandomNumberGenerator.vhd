----------------------------------------------------------------------------
-- Entity:       Register3
-- Written By:    Morayo Ogunsina
-- Date Created:  10/22/2015
-- Description:    Random Number Generator
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		FullAdder
--    InvertOrPass
--    OverflowDetect
--    RippleCarryAdder_4bit.
---------------------------------------------------------------------------library IEEE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity RandomNumbGenerator is
    port (D      : in  STD_LOGIC_VECTOR(15 downto 0);
          CLK    : in  STD_LOGIC;
		    CLEAR  : in  STD_LOGIC;
		    EN     : in  STD_LOGIC;
		    Qthree : out STD_LOGIC_VECTOR(15 downto 0));

end RandomNumbGenerator;


architecture Behavioral of RandomNumbGenerator is

   -- declare internal signals
  signal Q_int3 : STD_LOGIC_VECTOR(15 downto 0);
  signal Q_out  : STD_LOGIC_VECTOR(15 downto 0);
  signal EN_int : STD_LOGIC;
  
  -- instantiate the value of register2
  component Clock_50mhz_Counter is 
       port ( 
              CLR  : in STD_LOGIC;
			     CLK  : in STD_LOGIC;
			     Qtwo : out STD_LOGIC_VECTOR(15 downto 0) );
	end component;

begin
    --components instantiation
	 
      RG_NBIT : Register_nbit generic map(16) port map ( 
            D      =>  Q_int3,
		      LOAD   =>  EN_int,
		      CLK    =>  CLK ,
				CLR    =>  '0',
				Q      =>  Q_out);
				
      RG2 : Clock_50mhz_Counter port map (
		     
            CLK   =>  CLK,
		      CLR   =>  CLEAR,
		      Qtwo  =>  Q_int3);
	
	Qthree <= Q_out;
	
end Behavioral;