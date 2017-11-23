-----------------------------------------------------------------------------
-- Entity:        GRT4
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/30/2015
-- Description:   Compares four n-bit numbers for the least of all .
--
-- 
-- Dependencies:
--		CompareLES.
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


  entity LES4 is
 generic(n : integer := 4);
     Port ( A_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				C_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				D_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            LES_one   : out STD_LOGIC_VECTOR (n-1 downto 0));
 end LES4;

  architecture Behavioral of LES4 is
  
  --internal signals 
   signal les1    : STD_LOGIC_VECTOR(n-1 downto 0);
	signal les2    : STD_LOGIC_VECTOR(n-1 downto 0);
	signal Les_int : STD_LOGIC_VECTOR(n-1 downto 0);
	
 component CompareLES is 
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            LES : out STD_LOGIC_VECTOR (n-1 downto 0));
      end component CompareLES;
		
	begin

     COMPARE_AB  : CompareLES port map (
	               A     =>   A_one,
			         B     =>   B_one,
						LES   =>   les1);
						  
     COMPARE_CD  : CompareLES port map (
	               A    => C_one,
			         B    => D_one,
				      LES  => les2);
				  
    COMPARE_FINAL : CompareLES port map (
	               A   =>  les1,
			         B   =>  les2,
				      LES => Les_int);

    LES_one <= Les_int;

end Behavioral;