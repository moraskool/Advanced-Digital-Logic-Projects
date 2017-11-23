----------------------------------------------------------------------------
-- Entity:        RippleCarryAdder
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:   An RCA adder that adds two 4 bit numbers.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		FullAdder
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;

entity RippleCarryAdder_4bit is
      generic(n : integer := 4);
    Port ( A     : in   STD_LOGIC_VECTOR (n-1 downto 0);
           B     : in   STD_LOGIC_VECTOR (n-1downto 0);
			  SUM   : out  STD_LOGIC_VECTOR (n-1 downto 0);
           C_in  : in   STD_LOGIC;
           C_out : out  STD_LOGIC);
end RippleCarryAdder_4bit;

architecture Structural of RippleCarryAdder_4bit is

     -- declare the internal signals
 signal C    : STD_LOGIC_VECTOR(4 downto 0) ;
 
     -- declare the  FullAdder component
 component FullAdder is
    Port ( A     : in   STD_LOGIC;
           B     : in   STD_LOGIC;
           C_in  : in   STD_LOGIC;
           C_out : out  STD_LOGIC;
           SUM   : out  STD_LOGIC);
  end component;


  begin
  
  C(0) <= C_in;
      -- instantiate 4 full adders
 FA0 : FullAdder
       Port map( A     => A(0),
                 B     => B(0),
					  SUM   => SUM(0),
                 C_in  => C(0),
                 C_out => C(1));
 FA1 : FullAdder
       port map( A     => A(1),
                 B     => B(1),
					  SUM   => SUM(1),
                 C_in  => C(1),
                 C_out => C(2));
 FA2 : FullAdder
       port map( A     => A(2),
                 B     => B(2),
					  SUM   => SUM(2),
                 C_in  => C(2),
                 C_out => C(3));
 FA3 : FullAdder
       port map( A     => A(3),
                 B     => B(3),
					  SUM   => SUM(3),
                 C_in  => C(3),
                 C_out => C(4));
					  
	 C_out <= C(4);
end Structural;

