
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Lab_2tb IS
END Lab_2tb;
 
ARCHITECTURE behavior OF Lab_2tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Lab_2B
    PORT(
         SWITCH  : IN  std_logic_vector(7 downto 0);
         BTNU    : IN  std_logic;
         BTNC    : IN  std_logic;
         BTND    : IN  std_logic;
         ANODE   : OUT  std_logic_vector(7 downto 0);
         SEGMENT : OUT  std_logic_vector(6 downto 0);
         LED     : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SWITCH : std_logic_vector(7 downto 0) := (others => '0');
   signal BTNU   : std_logic := '0';
   signal BTNC   : std_logic := '0';
   signal BTND   : std_logic := '0';

 	--Outputs
   signal ANODE   : std_logic_vector(7 downto 0);
   signal SEGMENT : std_logic_vector(6 downto 0);
   signal LED     : std_logic_vector(7 downto 0);
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Lab_2B PORT MAP (
          SWITCH  => SWITCH,
          BTNU    => BTNU,
          BTNC    => BTNC,
          BTND    => BTND,
          ANODE   => ANODE,
          SEGMENT => SEGMENT,
          LED     => LED
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
          SWITCH     <= "00100111";
			 BTNU       <= '0';
			 BTNC       <= '1';
			 BTND       <='0';
			 
			 wait for 100 ns;
			 assert (SEGMENT  = "0001111" --2
                   and
                   ANODE   = "11111110"
                   and						 
			          LED     =  "10001001")--0
			    report "FAILURE: OVERFLOW and/or SUM does not equal expected value." 
			    severity failure;
      -- insert stimulus here 
      wait;
   END PROCESS stim_proc;
   

END;
