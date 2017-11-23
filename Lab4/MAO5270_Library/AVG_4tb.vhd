--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:44:33 10/11/2015
-- Design Name:   
-- Module Name:   P:/CMPEN371/Lab30/Lab30_mao5270/lab30_mao5270/AVG4_tb.vhd
-- Project Name:  lab30_mao5270
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: AVG_4
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY AVG4_tb IS
END AVG4_tb;
 
ARCHITECTURE behavior OF AVG4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AVG_4
    PORT(
         A_add : IN  std_logic_vector(3 downto 0);
         B_add : IN  std_logic_vector(3 downto 0);
         C_add : IN  std_logic_vector(3 downto 0);
         D_add : IN  std_logic_vector(3 downto 0);
         AVRG : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A_add : std_logic_vector(3 downto 0) := (others => '0');
   signal B_add : std_logic_vector(3 downto 0) := (others => '0');
   signal C_add : std_logic_vector(3 downto 0) := (others => '0');
   signal D_add : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal AVRG : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AVG_4 PORT MAP (
          A_add => A_add,
          B_add => B_add,
          C_add => C_add,
          D_add => D_add,
          AVRG => AVRG
        );

   
   -- Stimulus process
   stim_proc: process is
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;
          A_add <= "0101";
          B_add <= "0011";
          C_add <= "0000";
			 D_add <= "0000";
		wait for 100 ns;
		assert (AVRG = "0010" ) 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
		    A_add <= "0111";
          B_add <= "0010";
          C_add <= "0010";
			 D_add <= "0001";
		wait for 100 ns;
		assert (AVRG = "0011" ) 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
        wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

END;
