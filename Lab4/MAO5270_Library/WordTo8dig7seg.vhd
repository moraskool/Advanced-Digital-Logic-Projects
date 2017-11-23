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
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


 entity WordTo8dig7seg is
  Port (WORD    : in STD_LOGIC_VECTOR  (31 downto 0);
       STROBE   : in STD_LOGIC; 
		 CLK      : in STD_LOGIC;
		 DIGIT_EN : in STD_LOGIC_VECTOR  (7  downto 0);
		 ANODE    : out STD_LOGIC_VECTOR (7  downto 0);
		 CLR      : in STD_LOGIC; 
		 SEGMENT  : out STD_LOGIC_VECTOR (0  to 6));
 end WordTo8dig7seg;


architecture Behavioral of WordTo8dig7seg is

    -- declare the internal signals
       signal HEX_int      : STD_LOGIC_VECTOR(3 downto 0);
	    signal CLEAR_int    : STD_LOGIC;
		 signal Pulse_int    : STD_LOGIC;
       signal XO           : STD_LOGIC_VECTOR(15 downto 0);
		 signal X1           : STD_LOGIC_VECTOR(15 downto 0);
		 signal X2           : STD_LOGIC_VECTOR(15 downto 0);
		 signal X3           : STD_LOGIC_VECTOR(15 downto 0);
		 signal X4           : STD_LOGIC_VECTOR(15 downto 0);
		 signal X5           : STD_LOGIC_VECTOR(15 downto 0);
		 signal X6           : STD_LOGIC_VECTOR(15 downto 0);
		 signal X7           : STD_LOGIC_VECTOR(15 downto 0);
		 signal Sel_int      : STD_LOGIC_VECTOR(3 downto 0);
		 signal muxOut       : STD_LOGIC_VECTOR(15 downto 0);
		 signal Q_intW       : STD_LOGIC_VECTOR(2 downto 0);
begin
     
	   -- instantiate the Mux4To1 component
	  MUX_Word:  Mux4to1 generic map(4) port map(
		   X0     => WORD(3 downto 0),
         X1     => WORD(7 downto 4),
         X2     => WORD(11 downto 8),
         X3     => WORD(15 downto 12),
			X4     => WORD(31 downto 28),
			X5     => WORD(23 downto 20),
			X6     => WORD(27 downto 24),
			X7     => WORD(31 downto 28),
         SEL    => Q_intW(2 downto 0),
         Y      => HEX_int);
			
			-- instantiate the Mux4To1 component
	  MUX_Num:  Mux4to1 generic map(16) port map(
		   X0     =>  XO,
         X1     =>  X1,
         X2     =>  X2,
         X3     =>  X3 ,
			X4     =>  X4,
			X5     =>  X5,
			X6     =>  X6,
			X7     =>  X7,
         SEL    =>  Sel_int,
         Y      =>  muxOut);		
	  
        -- instantiate the Counter_nbit Component	
	 WORD_COUNTER : Counter_nbit generic map(3) port map (
		      EN     =>  Pulse_int,
			   CLK    =>  CLK, --BOARD CLOCK
			   CLR    =>  CLEAR_int, 
			   Q      =>  Q_intW);
				
         -- instantiate the HexToSevenSeg Component	
	 HEX2:  HexToSevenSeg port map (
           HEX      => Hex_int,
			  SEGMENT  => SEGMENT); 
			  
         -- instantiate the Decoder3to8 component
   DECD:   Decoder3to8 port map (
	        X   =>  Q_intW ,
		     EN  =>  DIGIT_EN,
		     YD  =>  ANODE);
			  
		   -----a clock pulse------
	P1000: PulseGenerator generic map (32, 104000) port map    
		  ( EN  	     => '1',     
			CLK 	     => CLK,	 
			CLR 		  => CLR,	 
			PULSE      => Pulse_int);		  
		
end Behavioral;

