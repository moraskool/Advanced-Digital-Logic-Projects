----------------------------------------------------------------------------
-- Entity:        Lab08_mao5270
-- Written By:    Morayo Ogunsina
-- Date Created:  10/26/2015
-- Description:   Displays on the vga monitor rectangular borders 
--                including a small box that is movable and allows for changing the colors of the screen 
--                 
-- Revision History (date, initials, description):
-- 
--    VGAContoller
--		ImageGenerator.
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity Lab08_mao5270 is
   port (SWITCH : in STD_LOGIC_VECTOR (11 downto 0);
	      BUTTON : in STD_LOGIC_VECTOR ( 0 to 4);
			CLK    : in STD_LOGIC;
			H_sync : out STD_LOGIC;
			V_sync : out STD_LOGIC;
			RGB_out :out STD_LOGIC_VECTOR(11 downto 0));
end Lab08_mao5270;

architecture Behavioral of Lab08_mao5270 is

   -----instantiate the internal signals------
   signal X_out   : STD_LOGIC_VECTOR(9 downto 0);
   signal Y_out   : STD_LOGIC_VECTOR(9 downto 0);
	signal RGB_int : STD_LOGIC_VECTOR(11 downto 0);
	
	 -----declare the VGAController-----
component VGAController is
     port (CLK     : in  STD_LOGIC;
			  RGB_in  : in  STD_LOGIC_VECTOR(11 downto 0);  
			  HSYNC   : out STD_LOGIC ;
			  VSYNC   : out STD_LOGIC ;
			  X_out   : out STD_LOGIC_VECTOR(9 downto 0);
	        Y_out   : out STD_LOGIC_VECTOR(9 downto 0);
			  RGB_out : out STD_LOGIC_VECTOR(11 downto 0));
end component;

     -----declare the ImageGenerator-----
component ImageGenerator is
 port     (BUTTON  : in  STD_LOGIC_VECTOR(0 to 4);
			  RGB_in  : in  STD_LOGIC_VECTOR(11 downto 0);    
			  X_in    : in  STD_LOGIC_VECTOR(9 downto 0);
	        Y_in    : in  STD_LOGIC_VECTOR(9 downto 0);
			  CLK     : in  STD_LOGIC;
			  RGB_out : out STD_LOGIC_VECTOR(11 downto 0));
end component;

begin
    
   ----Instantiate the ImageGenerator -----	
  VGA_GEN  : VGAController port map 
          (CLK      => CLK,
			  RGB_in   => RGB_int,
			  HSYNC    => H_sync,
			  VSYNC    => V_sync,
			  X_out    => X_out,
	        Y_out    => Y_out,
			  RGB_out  => RGB_out);
			  
	-----Instantiate the ImageGenerator -----		  
	IMAGE_GEN: ImageGenerator port map
          (BUTTON   => BUTTON,
			  RGB_in   => SWITCH, 
			  X_in     => X_out,
	        Y_in     => Y_out,
			  CLK      => CLK,
			  RGB_out  => RGB_int);

end Behavioral;

