----------------------------------------------------------------------------
-- Entity:        <Lab_3>
-- Written By:    <Marayo Ogunsina & Nadira Badrul>
-- Date Created:  <September 28, 2017>
-- Description:   < Displays sum of two elements on a seven seg display with controls >
--
-- Revision History (date, initials, description):
-- 
-- Dependencies: 
--            hex_display
--	          FullAdder_4bit
----------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lab3 is
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
end Lab3;

architecture Behavioral of Lab3 is

    signal counting: std_logic_vector(3 downto 0);
    signal C : STD_LOGIC_VECTOR(4 downto 0);
    signal SUM_int : STD_LOGIC_VECTOR(3 downto 0);
    
 --component FullAdder_4Bit declaration   
component FullAdder_4Bit 
Generic (AdderSize :integer :=4);
port (
       A : in STD_LOGIC_VECTOR (AdderSize-1 downto 0);
       B : in STD_LOGIC_VECTOR(AdderSize-1 downto 0);
       CIN : in STD_LOGIC;
       COUT : out STD_LOGIC; 
       EEEE : out STD_LOGIC_VECTOR(AdderSize-1 downto 0));
end component;

 --component hex_display declaration   
component hex_display 
     Port ( 
         value        : in std_logic_vector(3 downto 0);
         blank        : in std_logic;
         decimalpoint : in std_logic;
         test         : in std_logic;
         channels     : out std_logic;
         dp           : out std_logic;
         segs         : out std_logic_vector(6 downto 0));
 end component;

begin

  -- component FullAdder_4bit instantiation
      FullAdd4 : FullAdder_4bit
      Generic map(4)
      port map (
           A    => A(3 downto 0),
           B    => B(3 downto 0),
           CIN  => cin,
           COUT => cout,
           EEEE => SUM_int);

 -- component FullAdder_4bit instantiation
   Hex :hex_display
   port map  
      (    
    	value           => SUM_int, 
        blank           => blank,   
        decimalpoint    => decimalpoint,
        test            => test,        
    	channels        => channels,
    	dp              => dp,         
        segs            => segs 
        );   
        
end Behavioral;
