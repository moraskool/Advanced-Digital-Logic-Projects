----------------------------------------------------------------------------
-- Entity:        <hex_display_tb>
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


entity Lab3_tb is
--  Port ( );
end Lab3_tb;

architecture Behavioral of Lab3_tb is

component Lab3 is
 Port (      
       A            : in std_logic_vector(3 downto 0);
       B            : in std_logic_vector(3 downto 0);
       blank        : in std_logic;
       decimalpoint : in std_logic;
       test         : in std_logic;
       cin          : in std_logic;
       channels     : out std_logic;
       dp           : out std_logic;
       cout         : out std_logic;
       segs         : out std_logic_vector(6 downto 0));
end component;


 -- input signals
       signal a            : in std_logic_vector(3 downto 0);
       signal b            : in std_logic_vector(3 downto 0);
	   signal blank_out    : in std_logic;
	   signal show_decimal : in std_logic;
	   signal test_int     : in std_logic;
	   signal carryin      : in std_logic;
	   
	  -- output signals
	   signal channels_int : out std_logic;
	   signal decimal      : out std_logic;
	   signal carryout     : out std_logic;
	   signal segs_int      : out std_logic_vector(6 downto 0));
	   
begin

uut1: Lab3
   port map  
      (    
    	A               => a
    	B               => b   
        blank           => blank_out   
        decimalpoint    => show_decimal
        test            => test_int    
        cin             => carryin     
    	channels        => channels_int
    	dp              => decimal     
    	cout            => carryout    
        segs            => segs_int 
        );   
        
    simulation: process
    begin  
    
  	wait for 50 ns;
            
            for i in 0 to 127 loop
                 a <= "0011" ;
                 b <= "1011"; 
                 blank_out <= '0'; 
                 show_decimal <= '0';
                 test_int <= '0';
                 carryin <= '0';                
                 
            --   led_out <= input1 + input2;
               wait for 100 ns;
           end loop; 
            end process;        
 

end Behavioral;
