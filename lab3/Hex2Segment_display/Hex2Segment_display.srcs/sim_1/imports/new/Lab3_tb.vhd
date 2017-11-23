----------------------------------------------------------------------------
-- Entity:        <Lab3_tb>
-- Written By:    <Marayo Ogunsina & Nadira Badrul>
-- Date Created:  <September 28, 2017>
-- Description:   < The TestBench Simulation code for a full adder displayed on a 7 segment display >
--
-- Revision History (date, initials, description):
-- 
-- Dependencies: 
--            hex_display
--	
----------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use STD.textio.all;
use IEEE.std_logic_textio.all;


entity Lab3_tb is
--  Port ( );
end Lab3_tb;

architecture Behavioral of Lab3_tb is

--component Lab3 is
-- Port (      
--       A            : in std_logic_vector(3 downto 0);
--       B            : in std_logic_vector(3 downto 0);
--       blank        : in std_logic;
--       decimalpoint : in std_logic;
--       test         : in std_logic;
--       cin          : in std_logic;
--       channels     : out std_logic;
--       dp           : out std_logic;
--       cout         : out std_logic;
--       segs         : out std_logic_vector(6 downto 0));
--end component;

Component FullAdder_4Bit
	
	generic (AdderSize : integer :=4);
	port (
	    A : in STD_LOGIC_VECTOR (AdderSize-1 downto 0) ;
		B : in STD_LOGIC_VECTOR(AdderSize-1 downto 0) ;
		CIN : in STD_LOGIC;
		COUT : out STD_LOGIC; 
		EEEE : out STD_LOGIC_VECTOR(AdderSize-1 downto 0));
		
	End Component;
	
	Constant AdderSize : integer := 4;
	
	Signal input1 : STD_LOGIC_VECTOR(AdderSize-1 downto 0) := X"00";
	Signal input2 : STD_LOGIC_VECTOR(AdderSize-1 downto 0) := X"00";
	Signal ripplein : STD_LOGIC := '0';
	Signal rippleout : STD_LOGIC := '0';
	Signal led_out : STD_LOGIC_VECTOR(AdderSize-1 downto 0);
	Signal a : STD_LOGIC_VECTOR(AdderSize-1 downto 0);
	Signal b : STD_LOGIC_VECTOR(AdderSize-1 downto 0);
	Signal segs : STD_LOGIC_VECTOR(6 downto 0);
	Signal blank : STD_LOGIC;
	Signal test : STD_LOGIC;
	Signal dp : STD_LOGIC;
	Signal decimal : STD_LOGIC;
	
	Signal led_exp_out : STD_LOGIC_VECTOR(AdderSize-1 downto 0) := X"00";

	Signal count_int_2 : STD_LOGIC_VECTOR(AdderSize-1 downto 0) := X"00";
	

	procedure expected_led 
		( carryin: in  std_logic;
		in1 : in std_logic_vector(AdderSize-1 downto 0);
		in2 : in std_logic_vector(AdderSize-1 downto 0);
		carryout: out std_logic;
		led_expected : out std_logic_vector(AdderSize-1 downto 0)) is
	
	
		Variable led_expected_int : std_logic_vector(AdderSize-1 downto 0) := "0000";
		Variable carry_buffer : std_logic_vector(AdderSize downto 0) := "0000";
		
		Variable carryout_int : std_logic := '0';
        variable i : integer := 0;
        variable j : integer := 9;
		   
	begin		    
	
 		carry_buffer(0) := carryin;
		carryout_int :=  carry_buffer(AdderSize);
		for I in 0 to 7 loop
			led_expected_int(I) := in1(I) xor in2(I) xor carry_buffer(I);
			carry_buffer(I+1) := (in1(I) and in2(I)) or (in1(I) and carry_buffer(I)) or (in2(I) and carry_buffer(I));
			
		end loop;
		

	    led_expected := led_expected_int;
	    carryout := carryout_int; 
	end expected_led;
	
	--- start the architecture behavior
	
	
begin
-- uut1 : Lab3 
-- port map(
--       A            => input1,
--       B            => input2,
--       blank        => blank,
--       decimalpoint => decimal,
--       test         => test,
--       cin          => ripplein,
--       channels     => channels,
--       dp           => dp,
--       cout         => rippleout,
--       segs         => segs);
       
       
	uut:  FullAdder_4Bit 
	generic map (AdderSize   => 4)
	PORT MAP (
			A => input1,
			B => input2,
			CIN => ripplein,
			COUT => rippleout,
			EEEE => led_out );
	
		process
			variable s : line;
			variable i : integer := 0;
			variable count : integer := 0;
			variable proc_out : STD_LOGIC_VECTOR(AdderSize-1 downto 0);
			variable FinalCarry_out : STD_LOGIC;

	begin
	
	--for i in 0 to 127 loop   
    --              count := count + 1;
                              
    --              wait for 10 ns;
    --              input1 <= count_int_2;
    --              input2 <= count_int_2;
                  
    --              wait for 10 ns;
    --              expected_led (ripplein, input1,input2, FinalCarry_out,proc_out);
    --              led_exp_out <= proc_out;
    
    --              -- If the outputs match, then announce it to the simulator console.
    --              if  ((led_out = proc_out) and ( rippleout = FinalCarry_out) )then
    --                    write (s, string'("LED output MATCHED at ")); write (s, count ); write (s, string'(". Expected: ")); write (s, proc_out); write (s, string'(" Actual: ")); write (s, led_out); 
    --                    writeline (output, s);
    --              else
    --                  write (s, string'("LED output mis-matched at ")); write (s, count); write (s, string'(". Expected: ")); write (s, proc_out); write (s, string'(" Actual: ")); write (s, led_out); 
    --                  writeline (output, s);
    --              end if;
                          
    --              -- Increment the switch value counters.
    --              count_int_2 <= count_int_2 + 2;
    --             -- count_int_2 <= X"55";
    --            end loop;    
                
                wait for 50 ns;
                
                for i in 0 to 15 loop
                     input1 <= X"01" + input1;
                     ripplein <= '0';
                     
                       wait for 50 ns;             
                           for i in 9 to 12 loop;
                             input2 <= X"02" + input2;
                             ripplein <= '0';
                             
                             wait 50ns; 
                             end loop;
                      end loop;
                   wait for 100 ns;
               end loop;
            end process;    
    
    wait for 50 ns;
                
             
end Behavioral;
