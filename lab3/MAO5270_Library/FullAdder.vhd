----------------------------------------------------------------------------
-- Entity:        FullAdder
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:   A full adder that does addition and subtraction operations on two numbers.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FullAdder is
     Port ( A     : in   STD_LOGIC;
            B     : in   STD_LOGIC;
            C_in  : in   STD_LOGIC;
            C_out : out  STD_LOGIC;
            SUM   : out  STD_LOGIC);
end FullAdder;

architecture Dataflow of FullAdder is

begin
   C_out  <=  (A AND B) OR (A AND C_in) OR (C_in AND B);
	SUM    <=  (A XOR B) XOR(C_in);

end Dataflow;

