--------------------------------------------------------------------------
-- Entity:        ButtonEncoder_tb
-- Written By:    Morayo Ogunsina
-- Date Created:  Sept 23 2015
-- Description:   VHDL testbench for ButtonEncoder
-- 
-- Dependencies:
--   None.
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY ButtonEncoder_tb IS
END ButtonEncoder_tb;
 
ARCHITECTURE behavior OF ButtonEncoder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ButtonEncoder
    PORT(
         BTNU : IN  std_logic;
         BTNC : IN  std_logic;
         BTND : IN  std_logic;
         SEL : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal BTNU : std_logic := '0';
   signal BTNC : std_logic := '0';
   signal BTND : std_logic := '0';

 	--Outputs
   signal SEL : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ButtonEncoder PORT MAP (
          BTNU => BTNU,
          BTNC => BTNC,
          BTND => BTND,
          SEL  => SEL
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		    BTNU <= '1';
          BTNC <= '0';
          BTND <= '0';
			 wait for 100 ns;
			 assert (SEL = "00" )--0
			    report "FAILURE: OVERFLOW and/or SUM does not equal expected value." 
			    severity failure;
      -- insert stimulus here 
      wait;
   END PROCESS stim_proc;

END;
