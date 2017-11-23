---------------------------------------------------------------------------
-- Entity:        Mux4to1
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/17/2015
-- Description:   A generic 4to1 Mux.
--
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;

entity Mux4to1 is
    generic(n : integer := 4);
    Port ( X0  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X1  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X2  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X3  : in  STD_LOGIC_VECTOR (n-1 downto 0);
			  X4  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           SEL : in  STD_LOGIC_VECTOR (2 downto 0);
           Y   : out STD_LOGIC_VECTOR (n-1 downto 0));
end Mux4to1;

architecture Behavioral of Mux4to1 is

begin
    with SEL select
	 
      Y  <= X0 when "000",
	         X1 when "001",
			   X2 when "010",
			   X3 when "011",
				X4 when "101",
			  "0000" when others;
			  
end Behavioral;

