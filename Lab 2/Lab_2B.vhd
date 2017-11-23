----------------------------------------------------------------------------
-- Entity:        Lab_2B
-- Written By:    Morayo Ogunsina
-- Date Created:  9/17/15
-- Description:    Take in a 4 bit binary number and display it 
--                 on a seven segment display.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		AdderSubtractor_4bit
--    HexToSevenSeg
--    Mux4to1_4bit
--    ButtonEncoder
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Lab_2B is
    Port ( SWITCH  : in   STD_LOGIC_VECTOR (7 downto 0);
           BTNU    : in   STD_LOGIC;
           BTNC    : in   STD_LOGIC;
           BTND    : in   STD_LOGIC;
           ANODE   : out  STD_LOGIC_VECTOR (7 downto 0);
           SEGMENT : out  STD_LOGIC_VECTOR (6 downto 0);
           LED     : out  STD_LOGIC_VECTOR (7 downto 0));
end Lab_2B;

architecture Behavioral of Lab_2B is
 
    -- declare the internal signals
	 
	 signal overflow  : STD_LOGIC;
	 signal Sel_int   : STD_LOGIC_VECTOR(1 downto 0);
	 signal SUM_int   : STD_LOGIC_VECTOR(3 downto 0);
	 signal HEX_int   : STD_LOGIC_VECTOR(3 downto 0);
	 
   -- declare the HexToSevenSeg
  component HexToSevenSeg is
   Port  ( HEX    : in  STD_LOGIC_VECTOR (3 downto 0);
          SEGMENT : out  STD_LOGIC_VECTOR (0 to 6));
  end component;
  
  -- declare the Mus4to1_4bit
  component Mux4to1_4bit is
    Port ( X0     : in  STD_LOGIC_VECTOR (3 downto 0);
           X1     : in  STD_LOGIC_VECTOR (3 downto 0);
           X2     : in  STD_LOGIC_VECTOR (3 downto 0);
           X3     : in  STD_LOGIC_VECTOR (3 downto 0);
           SEL    : in  STD_LOGIC_VECTOR (1 downto 0);
           Y      : out STD_LOGIC_VECTOR (3 downto 0));
  end component;
  
  -- declare the ButtonEncoder
  component ButtonEncoder is
    Port ( BTNU   : in  STD_LOGIC;
           BTNC   : in  STD_LOGIC;
           BTND   : in  STD_LOGIC;
           SEL    : out STD_LOGIC_VECTOR (1 downto 0));
  end component;

   -- declare the AdderSubtractor_4bit
   component AdderSubtracator_4bit is
    Port ( A        : in  STD_LOGIC_VECTOR (3 downto 0);
           B        : in  STD_LOGIC_VECTOR (3 downto 0);
           SUBTRACT : in  STD_LOGIC;
           SUM      : out STD_LOGIC_VECTOR (3 downto 0);
           OVERFLOW : out STD_LOGIC);
   end component;
	
begin
   ANODE <= "11111110";
	
	 ADSUBTRACTOR: AdderSubtracator_4bit port map (
	              A        => SWITCH (7 downto 4),
                 B        => SWITCH (3 downto 0),
                 SUBTRACT => BTND,
                 SUM      => SUM_int(3 downto 0),
                 OVERFLOW => overflow);
					  
	         MX : Mux4to1_4bit port map  (
	                X0     => SWITCH (7 downto 4),
                   X1     => SWITCH (3 downto 0),
                   X2     => SUM_int,
                   X3     => SUM_int,
                   SEL    => SEL_int,
                   Y      => HEX_int );
				 
	       BTNCD  : ButtonEncoder port map (
		             BTNU   => BTNU,
                   BTNC   => BTNC,
                   BTND   => BTND, 
                   SEL    => SEL_int); 
					  
		    HX     : HexToSevenSeg port map (
                  HEX      => Hex_int,
					   SEGMENT  => SEGMENT);
						
			LED (3 downto 0) <= SUM_int;
			LED (7)          <= overflow;
			LED (6 downto 4) <= "000";
			
			
end Behavioral;

