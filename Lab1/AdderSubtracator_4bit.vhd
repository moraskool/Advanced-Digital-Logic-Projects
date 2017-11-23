----------------------------------------------------------------------------
-- Entity:        AdderSubtractor_4bit
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


entity AdderSubtracator_4bit is
    Port ( A        : in  STD_LOGIC_VECTOR (3 downto 0);
           B        : in  STD_LOGIC_VECTOR (3 downto 0);
           SUBTRACT : in  STD_LOGIC;
           SUM      : out STD_LOGIC_VECTOR (3 downto 0);
           OVERFLOW : out STD_LOGIC);
end AdderSubtracator_4bit;

architecture Structural of AdderSubtracator_4bit is

    -- declare the internal signals
	signal Sum_int      : STD_LOGIC_VECTOR (3 downto 0);
	signal Bxor_int     : STD_LOGIC_VECTOR (3 downto 0);
	
	-- declare the  RippleCarryAdder component
 component RippleCarryAdder_4bit is
     Port (A     : in   STD_LOGIC_VECTOR (3 downto 0);
           B     : in   STD_LOGIC_VECTOR (3 downto 0);
			  SUM   : out  STD_LOGIC_VECTOR (3 downto 0);
           C_in  : in   STD_LOGIC;
           C_out : out  STD_LOGIC);
end component;

    -- declare the  InvertOrPass component
component InvertOrPass is
	Port   ( B         : in  STD_LOGIC_VECTOR (3 downto 0);
            BXOR      : out  STD_LOGIC_VECTOR (3 downto 0);
            SUBTRACT  : in  STD_LOGIC);
end component;

   -- declare the  OverflowDetect component
	component OverflowDetect is 
	    Port ( A_MSB     : in  STD_LOGIC;
              B_MSB     : in  STD_LOGIC;
              SUM_MSB   : in  STD_LOGIC;
              SUBTRACT  : in  STD_LOGIC;
              OVERFLOW  : out STD_LOGIC);
end component;

begin

    OVFL : OverflowDetect  Port Map (
	               SUBTRACT => SUBTRACT,
						A_MSB    => A(3),
						B_MSB    => B(3),
						SUM_MSB  => Sum_int(3),
						OVERFLOW => OVERFLOW);
						
    RCA : RippleCarryAdder_4bit Port Map(
                  A     => A,
                  B     => Bxor_int,
						C_in  => SUBTRACT,
						C_out => OPEN,
						SUM   => Sum_int );
   
	INVP : InvertOrPass Port Map  (
	               B        => B,
						BXOR     => Bxor_int,
						SUBTRACT => SUBTRACT);
						
   
	 
--sum <= "1001";
   SUM  <= Sum_int;
end Structural;

