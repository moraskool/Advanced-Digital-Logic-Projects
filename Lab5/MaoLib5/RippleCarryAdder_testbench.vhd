----------------------------------------------------------------------------
-- Entity:        FullAdder_tb
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
  ENTITY RippleCarryAdder_testbench IS
  END RippleCarryAdder_testbench;
----------------------------------------------------------------------------
  architecture behavior of RippleCarryAdder_testbench is 

  -- Unit Under Test (UUT)
          component RippleCarryAdder_4bit
          Port ( A     : in   STD_LOGIC_VECTOR (3 downto 0);
                 B     : in   STD_LOGIC_VECTOR (3 downto 0);
                 C_in  : in   STD_LOGIC;
                 C_out : out  STD_LOGIC;
                 SUM   : out  STD_LOGIC_VECTOR (3 downto 0));
          END COMPONENT;

         --Inputs
     signal A    : STD_LOGIC_VECTOR (3 downto 0):= "0000";
     signal B    : STD_LOGIC_VECTOR (3 downto 0):= "0000";
     signal C_in : STD_LOGIC := '0';
      
        --Outputs
     signal C_out : STD_LOGIC;
     signal SUM   : STD_LOGIC_VECTOR (3 downto 0);		

  BEGIN

  -- Instantiate the Unit Under Test (UUT)
          uut: RippleCarryAdder_4bit PORT MAP(
                  A     => A,
                  B     => B,
						C_in  => C_in,
                  C_out => C_out,
						SUM   => SUM );

 -- Stimulus process
   stim_proc: process is
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;
     
		 A <= "0111";   --7
		 B <= "0101";   --5
		 C_in <= '0';   --0
		wait for 100 ns;
		assert (C_out = '0' --0
		          and
				SUM = "1100") --12
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
		
		 A <= "1011";   --11
		 B <= "0110";   --6
		 C_in <= '0';   --0
		wait for 100 ns;
		assert (C_out = '1' --0
		          and
				SUM = "0001") --17
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
        wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

  END;
