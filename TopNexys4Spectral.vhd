----------------------------------------------------------------------------------
-- Company: Digilent RO
-- Engineer: Mircea Dabacan
-- 
-- Create Date: 12/04/2014 07:52:33 PM
-- Design Name: Audio Spectral Demo 
-- Module Name: TopNexys4Spectral - Behavioral
-- Project Name: TopNexys4Spectral 
-- Target Devices: Nexys 4, Nexys 4 DDR
-- Tool Versions: Vivado 14.2
-- Description: The project:
--    gets PDM data from the built-in microphone,
--    digitally filters data for decimation and resolution (16 bit, 48KSPS),
--    reverberates the audio data and outputs it to the built-in Audio Out,
--    stores a frame of 1024 samples and shows it on a VGA display (640x480, 60Hz),
--    computes FFT of the stored data (512 bins x 46.875 Hz = 0...24KHz),
--    shows the first 80 FFT bins on the VGA display (80 bins x 46.875 Hz = 0...3.75KHz),
--    displays the first 30 FFT bins on an LED string (30 bins x 46.875 Hz = 0...1.4KHz), 
-- 
-- Dependencies: 
--    HW:
--       -- Nexys 4 or Nexys 4 DDR board (Digilent)
--       -- WS2812 LED Strip 
--              - GND(white) to JC pin5
--              - Vcc(red) to JC pin6
--              - data(green) to JC pin4 
--       -- VGA monitor (to the VGA connector of the NExys 4 or Nexys 4 DDR board) 
--       -- audio headspeakers (to the audio out connector)
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Modified by Morayo Ogunsina for use in another design project.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


library UNISIM;
use UNISIM.VComponents.all;

entity TopNexys4Spectral is
    Port ( ck100MHz : in STD_LOGIC;
           BTNL : in std_logic;
    -- microphone signals
           micData : in STD_LOGIC;
           micClk: inout STD_LOGIC;  -- microphone clk (3.072MHz)  --  inout, in fact out
           micLRSel: out STD_LOGIC;  -- microphone sel (0 for micClk rising edge)
    -- VGA signals
           vgaRed : out  STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out  STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out  STD_LOGIC_VECTOR (3 downto 0);
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
    -- PWM interface with the audio out
           pdm_data_o  : out std_logic;
           pdm_en_o    : out std_logic;

   -- on-board LEDs
           LED : out std_logic_vector(15 downto 0);  -- not used
   -- seven seg         
           channelsOUT : out std_logic_vector(7 downto 0);
           segsOUT : inout std_logic_vector(6 downto 0));
end TopNexys4Spectral;

architecture Behavioral of TopNexys4Spectral is

   signal wordTimeSample: std_logic_vector(15 downto 0); -- from audio_demo data_mic
                                           -- to dina of the Time buffer 
   signal flgTimeSampleValid: std_logic;   -- from audio_demo sample data_mic_valid
                                           --
   
     signal pulse_int : std_logic;
     signal pulse_int_10 : std_logic;
     signal R_en_int : std_logic;
     signal G_en_int : std_logic;
     signal B_en_int : std_logic;

     
     signal R_en : std_logic;
     signal G_en : std_logic;
     signal B_en : std_logic;
     signal row_int : std_logic_vector(9 downto 0);
     signal col_int : std_logic_vector(9 downto 0);
     signal RandOupt : std_logic_vector(15 downto 0);

component audio_demo is
   port(
   clk_i       : in  std_logic;
   rst_i       : in  std_logic;
   
   -- PDM interface with the MIC
   pdm_clk_o   : out std_logic;
   pdm_lrsel_o : out std_logic;
   pdm_data_i  : in  std_logic;
   
   -- parallel data from mic
   data_mic_valid : out std_logic;  -- 48MHz data enable
   data_mic       : out std_logic_vector(15 downto 0);  -- data from pdm decoder
  
   -- PWM interface with the audio out
   pdm_data_o  : out std_logic;
   pdm_en_o    : out std_logic
);
end component;
	
component count_display is
    Port ( 
		
		value : in std_logic_vector(15 downto 0);
		CLK100MHZ : in std_logic;
--	    RESETME : in std_logic;   
		channels : out std_logic_vector(7 downto 0);
	    segs : inout std_logic_vector(6 downto 0));
end component;
   
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
     
     component Register_nbit is
           generic(n : integer := 16);   -- NUMBER OF STAGES
             Port (D      :    in   STD_LOGIC_VECTOR (n-1 downto 0):= (OTHERS => '0');
                   LOAD   :    in   STD_LOGIC;
                   CLK    :    in   STD_LOGIC;
                     CLR    :  in   STD_LOGIC;
                     Q      :  out  STD_LOGIC_VECTOR(n-1 downto 0) := (OTHERS => '0'));
    end component;
   
begin         

Audio_demo_inst: audio_demo
      port map ( 
         clk_i         => ck100MHz,
         rst_i         => '0',            -- never reset audio_demo
   -- PDM interface with the MIC
         pdm_clk_o     => micClk,        
         pdm_data_i    => micData,                
         pdm_lrsel_o   => micLRSel,                
   -- parallel data from mic
         data_mic_valid => flgTimeSampleValid,   -- 48MHz data enable
         data_mic      => wordTimeSample,  -- provizoriu
   -- PWM interface with the audio out
         pdm_data_o    => pdm_data_o,          
         pdm_en_o      => pdm_en_o
      );
   
   PULSE25M : PulseGenerator 
          generic map (3, 3)    port map 
                   (EN          => '1',
                   CLK          => ck100MHz,
                   CLR          => '0',
                   PULSE        => pulse_int);
    
    PULSE1khz : PulseGenerator 
         generic map (17, 100000)    port map 
            (EN          => '1',
             CLK          => ck100MHz,
             CLR          => '0',
             PULSE        => pulse_int_10);
                       
        VGA :  VGA_Controller
          port map ( clock => pulse_int,
                     row => row_int, 
                     column => col_int,
                     H => Hsync, 
                     V => Vsync);
                     
         IMAGE : Image_Source 
             port map (
                    CLK => ck100MHz,
                    row => row_int,
                    column => col_int,
                    R_en => R_en_int,
                    G_en => G_en_int,
                    B_en => B_en_int,
                    R  => vgaRed, 
                    G  => vgaGreen,
                    B  => vgaBlue   );  
  
 -- this process handles the comparison of the 16 bit input string to trigger the RED, GREEN AND BLUE blocks on the vga  
 RGB_en : process(ck100MHz,flgTimeSampleValid,wordTimeSample)
     begin
     if(ck100MHz'EVENT AND ck100MHz = '1') then
           if (flgTimeSampleValid = '1')then
              if (wordTimeSample(10 downto 3) > "00000011" and wordTimeSample(10 downto 3) < "01010101" )  then --1 - 33
                  R_en_int <= '1';  
                  G_en_int <= '0'; 
                  B_en_int <= '0'; 
            else
                R_en_int <= '0';               
            end if;
             if ( wordTimeSample(10 downto 3) > "01010111" and wordTimeSample(10 downto 3) < "10101010" )  then --34 - 66
                  G_en_int <= '1'; 
                  R_en_int <= '0'; 
                  B_en_int <= '0'; 
           else
                G_en_int <= '0';              
           end if;
             if ( wordTimeSample(10 downto 3) = "10101011" and wordTimeSample(10 downto 3) < "11010111" )  then
                  B_en_int <= '1';
                  R_en_int <= '0';  
                  G_en_int <= '0'; 
             else 
                  B_en_int <= '0';                
             end if;
           end if;
        end if;
     end process; 
    
--    R_en_int <= '1' when flgTimeSampleValid = '1' and (wordTimeSample(10 downto 3) > "00000011" and wordTimeSample(10 downto 3) < "00010101") else '0';
--    G_en_int <= '1' when flgTimeSampleValid = '1' and (wordTimeSample(10 downto 3) > "00011101" and wordTimeSample(10 downto 3) < "00111101") else '0';
--    B_en_int <= '1' when flgTimeSampleValid = '1' and (wordTimeSample(10 downto 3) = "00111111" and wordTimeSample(10 downto 3) < "01110101") else '0';

-- use this to debug the red, green and blue enable signals 
-- R_en_int <= SW(0);
-- G_en_int <= SW(1);
-- B_en_int <= SW(2);   
 
 ----OUTPUT RANDOM AUDIO SAMPLE TO SEVEN SEGMENT---------------------------------------------------	
       RAND : Register_nbit generic map(16)  port map 
              (D     =>  wordTimeSample, 
               LOAD  =>  pulse_int_10,   -- can use a button here to load random sample of 16 bit audio string to seven seg
               CLK   =>  ck100MHz,
               CLR   =>  '0',
               Q     =>  RandOupt);  
                 
      seven_seg : count_display port map
           (  
             value => RandOupt,
             CLK100MHZ=> ck100MHz,  
             channels => channelsOUT,
             segs => segsOUT);
              
LED(12 downto 0) <= wordTimeSample(15 downto 3);
LED(15) <= R_en_int;
LED(14) <= G_en_int;
LED(13) <= B_en_int;



end Behavioral;
