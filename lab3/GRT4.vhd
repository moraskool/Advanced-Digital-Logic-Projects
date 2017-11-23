-----------------------------------------------------------------------------
-- Entity:        GRT4
-- Written By:    Morayo OGUNSINA
-- Date Created:  9/17/2015
-- Description:   A generic comparator that checks if an n-bit number ,A is greater than B .
--
-- 
-- Dependencies:
--		None.
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


  entity GRT4 is
 generic(n : integer := 4);
     Port ( A_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				C_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				D_one     : in  STD_LOGIC_VECTOR (n-1 downto 0);
            GRT_one   : out STD_LOGIC_VECTOR (n-1 downto 0));
 end   GRT4;

  architecture Behavioral of GRT4 is
  
  --internal signals 
   signal grt1    : STD_LOGIC_VECTOR(n-1 downto 0);
	signal grt2    : STD_LOGIC_VECTOR(n-1 downto 0);
	signal GRT_int : STD_LOGIC_VECTOR(n-1 downto 0);
	
 component CompareGRT is 
     Port ( A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
            GRT : out STD_LOGIC_VECTOR (n-1 downto 0));
      end component CompareGRT;
		
	begin

     COMPARE_AB  : CompareGRT port map (
	               A     =>   A_one,
			         B     =>   B_one,
						GRT   =>   grt1);
						  
     COMPARE_CD  : CompareGRT port map (
	               A    => C_one,
			         B    => D_one,
				      GRT  => grt2);
				  
    COMPARE_FINAL : CompareGRT port map (
	               A   =>  grt1,
			         B   =>  grt2,
				      GRT => GRT_int);

    GRT_one <= GRT_int;

end Behavioral;