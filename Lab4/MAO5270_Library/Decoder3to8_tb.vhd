----------------------------------------------------------------------------
-- Entity:        Decoder3To8_tb
-- Written By:    Morayo Ogunsina
-- Date Created:   Oct 8 2015
-- Description:   VHDL testbench for Decoder3To8
--
-- 
-- Dependencies:
--   None.
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY Decoder3to8_tb IS
END Decoder3to8_tb;
 
ARCHITECTURE behavior OF Decoder3to8_tb IS 
 
    -- Unit Under Test (UUT)
    COMPONENT Decoder3to8
    PORT(
         X : IN  std_logic_vector(2 downto 0);
         EN : IN  std_logic;
         YD : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(2 downto 0) := (others => '0');
   signal EN : std_logic := '0';

 	--Outputs
   signal YD : std_logic_vector(7 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder3to8 PORT MAP (
          X => X,
          EN => EN,
          YD => YD
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      X  <= "011";
		EN <= '0';
		
      assert (YD = "00000000")
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
		
		  X <= "001";   
		 EN <= '1';   
		wait for 100 ns;
		assert (YD = "00000010") 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
        wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

END;
