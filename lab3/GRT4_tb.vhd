--------------------------------------------------------------------------
-- Entity:        GRT4_tb
-- Written By:    Morayo Ogunsina
-- Date Created:  Oct 7 2015
-- Description:   VHDL testbench for Greater than comparator
-- 
-- Dependencies:
--   CompareGRT
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY GRT4_tb IS
END GRT4_tb;
 
ARCHITECTURE behavior OF GRT4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GRT4
    PORT(
         A_one : IN  std_logic_vector(3 downto 0);
         B_one : IN  std_logic_vector(3 downto 0);
         C_one : IN  std_logic_vector(3 downto 0);
         D_one : IN  std_logic_vector(3 downto 0);
         GRT_one : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A_one : std_logic_vector(3 downto 0) := (others => '0');
   signal B_one : std_logic_vector(3 downto 0) := (others => '0');
   signal C_one : std_logic_vector(3 downto 0) := (others => '0');
   signal D_one : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal GRT_one : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GRT4 PORT MAP (
          A_one => A_one,
          B_one => B_one,
          C_one => C_one,
          D_one => D_one,
          GRT_one => GRT_one
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		    A_one <= "0011";
          B_one <= "0101";
          C_one <= "1100";
			 D_one <= "0001";
			 wait for 100 ns;
			 assert (GRT_one = "1100" )--0
			    report "FAILURE: SEL does not equal expected value." 
			    severity failure;
				 
		    A_one <= "0111";
          B_one <= "1001";
          C_one <= "1110";
			 D_one <= "0101";
			 wait for 100 ns;
			 assert (GRT_one = "1110" )--0
			    report "FAILURE: SEL does not equal expected value." 
			    severity failure;
      -- insert stimulus here 
      wait;
   END PROCESS stim_proc;

END;
