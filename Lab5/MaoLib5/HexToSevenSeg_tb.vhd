--------------------------------------------------------------------------
-- Entity:        HexToSevenSeg_tb
-- Written By:    Morayo Ogunsina
-- Date Created:  Sept 23 2015
-- Description:   VHDL testbench for HexToSevenSeg
-- 
-- Dependencies:
--   None.
----------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY HexToSevenSeg_tb IS
END HexToSevenSeg_tb;
 
ARCHITECTURE behavior OF HexToSevenSeg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HexToSevenSeg
    PORT(
         HEX : IN  std_logic_vector(3 downto 0);
         SEGMENT : OUT  std_logic_vector(0 to 6)
        );
    END COMPONENT;
    

   --Inputs
   signal HEX : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal SEGMENT : std_logic_vector(0 to 6);
  
 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HexToSevenSeg PORT MAP (
          HEX => HEX,
          SEGMENT => SEGMENT
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
          HEX<= "1111";
			 wait for 100 ns;
			 assert (SEGMENT = "0111000" )--0
			    report "FAILURE: OVERFLOW and/or SUM does not equal expected value." 
			    severity failure;
      -- insert stimulus here 
      wait;
   END PROCESS stim_proc;

      -- insert stimulus here 

END;
