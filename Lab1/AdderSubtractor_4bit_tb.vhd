----------------------------------------------------------------------------
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
  USE ieee.numeric_std.ALL;

----------------------------------------------------------------------------
  ENTITY AdderSubtractor_4bit_tb IS
  END AdderSubtractor_4bit_tb;
----------------------------------------------------------------------------
  architecture behavior of AdderSubtractor_4bit_tb is 

  -- Unit Under Test (UUT)
          component AdderSubtractor_4bit
          Port ( A        : in  STD_LOGIC_VECTOR (3 downto 0);
                 B        : in  STD_LOGIC_VECTOR (3 downto 0);
                 SUBTRACT : in  STD_LOGIC;
                 SUM      : out STD_LOGIC_VECTOR (3 downto 0);
                 OVERFLOW : inout STD_LOGIC);
          END COMPONENT;

         --Inputs
     signal A        : STD_LOGIC_VECTOR (3 downto 0):= "0000";
     signal B        : STD_LOGIC_VECTOR (3 downto 0):= "0000";
     signal SUBTRACT : STD_LOGIC := '0';
      
        --Outputs
     signal SUM       : STD_LOGIC_VECTOR (3 downto 0);
     signal OVERFLOW  : STD_LOGIC;		

  BEGIN

  -- Instantiate the Unit Under Test (UUT)
          uut: AdderSubtractor_4bit PORT MAP(
                  A         => A,
                  B         => B,
						SUBTRACT  => SUBTRACT,
                  SUM       => SUM,
						OVERFLOW  => OVERFLOW );

 -- Stimulus process
   stim_proc: process is
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;
      --test for addition
		 A        <= "1111";   --binary value for 7
		 B        <= "1100";   --binary value for 5
		 SUBTRACT <= '0';      --binary value for 0
		wait for 100 ns;
		assert (OVERFLOW = '1' --0
		          and
				  SUM = "1011") --12
			report "FAILURE: OVERFLOW and/or SUM does not equal expected value." 
			severity failure;
		--test for subtraction
		 A        <= "1011";   --11
		 B        <= "0110";   --6
		 SUBTRACT <= '1';      --SUBTRACT IS
		wait for 100 ns;
		assert (OVERFLOW = '0' --0
		          and
				  SUM = "0101") --17
			report "FAILURE: OVERFLOW and/or SUM does not equal expected value." 
			severity failure;
        wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

  END;
