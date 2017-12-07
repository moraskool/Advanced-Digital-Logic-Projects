----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2017 03:48:24 PM
-- Design Name: 
-- Module Name: Top_Level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VisualAudio is
  Port ( CLK : IN STD_LOGIC;
         R_EN : IN STD_LOGIC;
         G_EN : IN STD_LOGIC;
         B_EN : IN STD_LOGIC;
         HSYNC   : OUT STD_LOGIC;
         VSYNC   : OUT STD_LOGIC;
         R_vga   : OUT STD_LOGIC_VECTOR (3 downto 0);
         G_vga   : OUT STD_LOGIC_VECTOR (3 downto 0);
         B_vga   : OUT STD_LOGIC_VECTOR (3 downto 0)
         );
end VisualAudio;

architecture Behavioral of VisualAudio is

 component VGA_Controller is
    port( clock          : in std_logic;  -- 25.175 Mhz clock
        row, column      : out std_logic_vector(9 downto 0); -- for current pixel
         H, V : out std_logic); -- VGA drive signals
  end component;
  
  component Image_Source is
    port(
         CLK           : in std_logic;
         row, column   : in std_logic_vector(9 downto 0);
         R_en, G_en, B_en : in std_logic;
         R, G, B       : out std_logic_vector(3 downto 0) := (others => '0'));
  end component;
  
  component PulseGenerator is
     generic (n        : integer := 4;
               maxCount : integer := 15);
     port    (EN       : in  STD_LOGIC;
              CLK      : in  STD_LOGIC;
              CLR      : in  STD_LOGIC;
              PULSE    : out STD_LOGIC);    
  end component;
  
  signal pulse_int : std_logic;
  signal row_int : std_logic_vector(9 downto 0);
  signal col_int : std_logic_vector(9 downto 0);
  
  
begin
 PULSE25M : PulseGenerator 
		generic map (3, 3)	port map 
           	(EN    	    => '1',
		     CLK   	    => CLK,
			 CLR  		=> '0',
			 PULSE      => pulse_int);
			 
 -- for debugging: to view the bit order
  VGA :  VGA_Controller
    port map ( clock => pulse_int,
               row => row_int, 
               column => col_int,
               H => HSYNC, 
               V => VSYNC);
               
   IMAGE : Image_Source 
       port map (
              CLK => CLK,
              row => row_int,
              column => col_int,
              R_en => R_EN,
              G_en => G_EN,
              B_en => B_EN,
              R  => R_vga, 
              G  => G_vga,
              B  => B_vga   );   
       
end Behavioral;
