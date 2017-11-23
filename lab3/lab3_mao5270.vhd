----------------------------------------------------------------------------
-- Entity:        Lab03_ma05270
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:   A full adder that does addition and subtraction operations on two numbers.>
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		AdderSubtractor
--    HexToSevenSeg
--    Mux4to1
--    CompareGRT
--    CompareLES
--		AVG_4
--		Decoder3to8
--    ButtonEncoder
--    GRT4
--    LES4
		
---------------------------------------------------------------------------
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all; 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------------------------------------------
entity Lab3_mao5270 is
    Port ( SWITCH  : in   STD_LOGIC_VECTOR (15 downto 0);
           BTNL    : in   STD_LOGIC;
           BTNR    : in   STD_LOGIC;
           BTNU    : in   STD_LOGIC;
			  BTND    : in   STD_LOGIC;
			  BTNC    : in   STD_LOGIC; 
           ANODE   : out  STD_LOGIC_VECTOR (7 downto 0);
           SEGMENT : out  STD_LOGIC_VECTOR (6 downto 0);
           LED     : out  STD_LOGIC_VECTOR (15 downto 0));
end lab3_mao5270;

architecture Behavioral of lab3_mao5270 is

    -- declare the internal signals
----------------------------------------------------------------------------------------------------------------	
	 signal LED_int	 : STD_LOGIC_VECTOR (15 downto 0);
 
	 signal overflow   : STD_LOGIC;
	 signal Sel_int    : STD_LOGIC_VECTOR(2 downto 0);
	 signal SUM_int    : STD_LOGIC_VECTOR(3 downto 0);
	 signal DIFF_int    : STD_LOGIC_VECTOR(3 downto 0);
	 signal MAX_int    : STD_LOGIC_VECTOR(3 downto 0);
	 signal MIN_int    : STD_LOGIC_VECTOR(3 downto 0);
	 signal MEAN_int   : STD_LOGIC_VECTOR(3 downto 0);
	 signal EN_int     : STD_LOGIC;
	 signal MUX_out    : STD_LOGIC_VECTOR (3 downto 0);
	 signal HEX_int    : STD_LOGIC_VECTOR(3 downto 0);
    signal NoButton   : STD_LOGIC;
    -- declare newly created components
----------------------------------------------------------------------------------------------------------------		 
    --declare the Decoder3to8 component
    component  Decoder3to8 is
     Port ( X    : in  STD_LOGIC_VECTOR (2 downto 0);
            EN   : in  STD_LOGIC;
            YD   : out STD_LOGIC_VECTOR (7 downto 0));
   end component;
  
   --declare the  EQU4 component
   component CompareEQU is
   generic(n : integer := 4);
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            EQU : out STD_LOGIC);
   end component;
 
   --declare the  GRT4 component
   component CompareGRT is
     generic(n : integer := 4);     
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            GRT : out STD_LOGIC);
   end component;
 
   --declare the  LES4 component
   component CompareLES is
   generic(n : integer := 4);
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            LES : out STD_LOGIC);
   end component;
	
   --declare the  GRT4 components
   component GRT4 is
   generic(n : integer := 4);
     Port ( A_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				C_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				D_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            GRT_one   : out STD_LOGIC_VECTOR (n-1 downto 0));
   end component;
  
  --declare the LES4 component
   component LES4 is
    generic(n : integer := 4);
     Port ( A_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				C_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				D_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            LES_one   : out STD_LOGIC_VECTOR (n-1 downto 0));
	end component;
	
	
  -- declare the AVG_4 component
   component  AVG_4 is 
    Port ( A_add   : in   STD_LOGIC_VECTOR (3 downto 0);
           B_add   : in   STD_LOGIC_VECTOR (3 downto 0);
			  C_add   : in   STD_LOGIC_VECTOR (3 downto 0);
			  D_add   : in   STD_LOGIC_VECTOR (3 downto 0);
           AVRG    : out   STD_LOGIC_VECTOR(3 downto 0));
	end component;
--------------------------------------------------------------------------------------------------------------------		     
 begin
	
	-- EN_int
	EN_int <= (not BTNL) and (not BTNR) and (not BTNU) and (not BTND) and (not BTNC); 
	
	-- HEX_int 
	HEX_int <= SWITCH(15 downto 12) when EN_int = '1' else 
				 MUX_out;
	
	-- instantiate the adder subtractor
   ADS:  AdderSubtracator generic map(4) port map (
	      A        => SWITCH (15 downto 12),
         B        => SWITCH (11 downto 8),
         SUBTRACT => BTNR,
         SUM      => SUM_int(3 downto 0),
         OVERFLOW => overflow);
			
	-- instantiate the ButtonEncoder	
	BTNEE: ButtonEncoder  port map (    
			  BTNL    =>  BTNL,
           BTNR    =>  BTNR,
           BTNU    =>  BTNU,
			  BTND    =>  BTND,
			  BTNC    =>  BTNC,
           SEL     =>  SEL_int); 
			
    -- instantiate the GRT4 component
	GR: GRT4 generic map(4) port map (
	      A_one   =>  SWITCH (15 downto 12),
			B_one   =>  SWITCH (11 downto 8),
			C_one   =>  SWITCH (7 downto 4),
		   D_one   =>  SWITCH (3 downto 0),
			GRT_one =>  MAX_int);
	
	-- instantiate the LES4 component
	LE: LES4 generic map(4) port map (
	      A_one   =>  SWITCH (15 downto 12),
			B_one   =>  SWITCH (11 downto 8),
			C_one   =>  SWITCH (7 downto 4),
		   D_one   =>  SWITCH (3 downto 0),
			LES_one =>  MIN_int);
	
	-- instantiate the AVG_4 component
	AVERAGE : AVG_4 port map (
	      A_add   => SWITCH(15 downto 12),  
         B_add   => SWITCH(11 downto 8),
         C_add   => SWITCH(7 downto 4),
         D_add   => SWITCH(3 downto 0),		
	      AVRG    => MEAN_int);
	
	-- instantiate the Mux4To1 component
	MUX_Num:  Mux4to1 generic map(4) port map(
		   X0     => SUM_int,
         X1     => SUM_int,
         X2     => MAX_int,
         X3     => MIN_int,
			X4     => MEAN_int,
         SEL    => SEL_int,
         Y      => Mux_out);
		
   -- instantiate the HexToSevenSeg Component	
	HEX2:   HexToSevenSeg port map (
           HEX      => Hex_int,
			  SEGMENT  => SEGMENT);  
			  
	-- instantiate the Decoder3to8 component
   DECD: Decoder3to8 port map (
	       X   => SWITCH(15 downto 13),
		    EN  => En_int,
		    YD  => ANODE);
			 
  LED_int(15 downto 12) <= SWITCH(15 downto 12);
  LED_int(11 downto 8)  <= SWITCH(11 downto 8);
  LED_int(7 downto 4)   <= SWITCH(7 downto 4);
  LED_int(3 downto 0)   <= SWITCH(3 downto 0);
			 

  LED (15 downto 12) <= LED_int(15 downto 12);
  LED (11 downto 8)  <= LED_int(11 downto 8);
  LED (7 downto 4)   <= LED_int(7 downto 4);
  LED (3 downto 0)   <= LED_int(3 downto 0);
end Behavioral;

