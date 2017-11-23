
-- Entity:        AdderSubtractor_4bit_tb
-- Written By:    E. George Walters
-- Date Created:  18 Aug 13
-- Description:   VHDL testbench for RippleCarryAdder_4bit
--
-- Revision History (date, initials, description):
--   26 Aug 14, egw100, Modified port signal names to reflect course standard
-- 
-- Dependencies:
--   FullAdder
----------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY AdderSub_4bit_tb IS
END AdderSub_4bit_tb;
 
ARCHITECTURE behavior OF AdderSub_4bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AdderSubtracator_4bit
    PORT(
         A :      IN  std_logic_vector(3 downto 0);
         B :      IN  std_logic_vector(3 downto 0);
         SUBTRACT : IN  std_logic;
         SUM : OUT  std_logic_vector(3 downto 0);
         OVERFLOW : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A        : std_logic_vector(3 downto 0) := (others => '0');
   signal B        : std_logic_vector(3 downto 0) := (others => '0');
   signal SUBTRACT : std_logic := '0';

	  --Outputs
     signal OVERFLOW : STD_LOGIC;
     signal SUM      : STD_LOGIC_VECTOR (3 downto 0);	

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AdderSubtracator_4bit PORT MAP (
          A        => A,
          B        => B,
          SUBTRACT => SUBTRACT,
          SUM      => SUM,
          OVERFLOW => OVERFLOW
        );

   -- Stimulus process
   stim_proc: process is
   begin		
      -- hold reset state for 100 ns.
		wait for 10 ns;
     
		 A        <= "0111";   --7
		 B        <= "0101";   --5
		 SUBTRACT <= '1';      --0
		wait for 100 ns;
		assert (OVERFLOW = '0' --0
		          and
				SUM = "0010")   --12
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
		
		 A        <= "1011";   --11
		 B        <= "0110";   --6
		 SUBTRACT <= '0';      --0
		wait for 100 ns;
		assert (OVERFLOW = '0' --0
		          and
				SUM = "0001") --17
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
        wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

END;
