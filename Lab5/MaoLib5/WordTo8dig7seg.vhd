----------------------------------------------------------------------------
-- Entity:        WordTo8dig7seg
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:    Converts a 31-bit hexadecimal number to the segment and anode
--                 values needed to display the number on an 8-digit 7-segment 
--                 display
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


 entity WordTo8dig7seg is
  Port (WORD    : in STD_LOGIC_VECTOR  (31 downto 0);
       STROBE   : in STD_LOGIC; 
		 CLK      : in STD_LOGIC;
		 CLR      : in STD_LOGIC;
		 DIGIT_EN : in STD_LOGIC_VECTOR  (7  downto 0);
		 ANODE    : out STD_LOGIC_VECTOR (7  downto 0);
		 SEGMENT  : out STD_LOGIC_VECTOR (0  to 6));
 end WordTo8dig7seg;


architecture Behavioral of WordTo8dig7seg is

    -- declare the internal signals
       signal HEX_int      : STD_LOGIC_VECTOR(3 downto 0);
	    signal CLEAR_int    : STD_LOGIC;
		 signal muxOut       : STD_LOGIC_VECTOR(15 downto 0);
		 signal Q_intW       : STD_LOGIC_VECTOR(2 downto 0);
		 
		 constant  maxCount : integer := 7;
begin
     
	   -- instantiate the Mux4To1 component
	  MUX_Word:  Mux4to1 generic map(4) port map(
		   X0     => WORD(3 downto 0),
         X1     => WORD(7 downto 4),
         X2     => WORD(11 downto 8),
         X3     => WORD(15 downto 12),
			X4     => WORD(19 downto 16),
			X5     => WORD(23 downto 20),
			X6     => WORD(27 downto 24),
			X7     => WORD(31 downto 28),
         SEL    => Q_intW,
         Y      => HEX_int);
	  
        -- instantiate the Counter_nbit Component	
	 WORD_COUNTER : Counter_nbit generic map(3) port map (
		      EN     =>  STROBE,
			   CLK    =>  CLK, --BOARD CLOCK
			   CLR    =>  CLEAR_int, 
			   Q      =>  Q_intW);
				
         -- instantiate the HexToSevenSeg Component	
	 HEX2:  HexToSevenSeg port map (
           HEX      => Hex_int,
			  SEGMENT  => SEGMENT); 
			  
         -- instantiate the Decoder3to8 component
   DECD:   Decoder3to8 port map (
	        X   =>  Q_intW,
		     EN  =>  DIGIT_EN,
		     YD  =>  ANODE);		  
		
		
		---CHECK WHEN COUNTER HAS COUNTED TO 7,THEN CLEAR IT AND START AGAIN-- 
 	CLEAR_int   <= '1' when (to_integer(unsigned(Q_intW)) = maxCount) else  
 					   '1' when (CLR = '1') else 
 					   '0';  

end Behavioral;

