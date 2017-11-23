-----------------------------------------------------------------------------
-- Entity:        GRT4
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/30/2015
-- Description:   Compares if two n-bit numbers are equal.
--
-- 
-- Dependencies:
--		CompareEQU.
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


  entity EQU4 is
 generic(n : integer := 4);
     Port ( A_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				C_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				D_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            EQU_one   : out STD_LOGIC_VECTOR (n-1 downto 0));
 end EQU4;

  architecture Behavioral of EQU4 is
  
   --internal signals 
   signal equ1    : STD_LOGIC_VECTOR(n-1 downto 0);
	signal equ2    : STD_LOGIC_VECTOR(n-1 downto 0);
	signal EQU_int : STD_LOGIC_VECTOR(n-1 downto 0);
	
   component CompareEQU is 
     generic(n : integer := 4);
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            EQU : out STD_LOGIC_VECTOR (n-1 downto 0));
      end component CompareEQU;
		
 begin

     COMPARE_AB  : CompareEQU port map (
	               A     =>   A_one,
			         B     =>   B_one,
						EQU   =>   equ1);
						  
     COMPARE_CD  : CompareEQU port map (
	               A    => C_one,
			         B    => D_one,
				      EQU  => equ2);
				  
    COMPARE_FINAL : CompareEQU port map (
	               A   =>  equ1,
			         B   =>  equ2,
				      EQU => EQU_int);

    EQU_one <= EQU_int;

end Behavioral;