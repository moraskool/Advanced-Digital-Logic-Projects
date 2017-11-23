----------------------------------------------------------------------------
-- Entity:        VGAContoller
-- Written By:    Morayo OGUNSINA
-- Date Created:  10/26/2015
-- Description:   Used to control a VGA monitor at 640 X 480 resolution.
--                
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		PulseGenerator
--    Counter_nbit
--    Comparator  : CompareLES,CompareEQU,CompareGRT
---------------------------------------------------------------------
 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity VGAController is
     port (CLK     : in  STD_LOGIC;
			  RGB_in  : in  STD_LOGIC_VECTOR(11 downto 0);  
			  HSYNC   : out STD_LOGIC ;
			  VSYNC   : out STD_LOGIC ;
			  X_out   : out STD_LOGIC_VECTOR(9 downto 0);
	        Y_out   : out STD_LOGIC_VECTOR(9 downto 0);
			  RGB_out : out STD_LOGIC_VECTOR(11 downto 0));
end VGAController;

architecture Behavioral of VGAController is

   -------------internal signals------------
	signal Pulse_pixel   :  STD_LOGIC;
	signal D_intH        :  STD_LOGIC;
	signal D_intV        :  STD_LOGIC;
	signal HSyncOut      :  STD_LOGIC;
	signal VSyncOut      :  STD_LOGIC;
	signal R_Dff         :  STD_LOGIC;
	signal RGB_Enable_Reg:  STD_LOGIC;
	
	------------Horizontal Signals-----------
	signal Hcount		: STD_LOGIC_VECTOR(9 downto 0);  
   signal Hactive 	: STD_LOGIC; 
   signal RollH		: STD_LOGIC; 
   signal HcountClr	: STD_LOGIC; 
   signal H_LT656		: STD_LOGIC; 
   signal H_GT751	   : STD_LOGIC; 
	signal CLR_intX   : STD_LOGIC;
  
   ------------Vrtical Signals-----------
	signal Vcount		: STD_LOGIC_VECTOR(9 downto 0);  
   signal Vactive 	: STD_LOGIC; 
	signal EN_intV    : STD_LOGIC; 
   signal RollV	   : STD_LOGIC; 
   signal CLR_intV	: STD_LOGIC; 
   signal V_LT490		: STD_LOGIC; 
   signal V_GT491		: STD_LOGIC; 
 
    
begin
  --------------------------------------------------------------------
  ----------------------Horizontal------------------------------------  
	   -------PulseGenerator for a 25MHz clock-------
		
		
	PULSE25 :PulseGenerator  generic map (3, 3) port map       
           (EN      => '1',
	         CLK     => CLK,
            CLR     => '0',
            PULSE   => Pulse_pixel);

    ----------CompareEQU----------------
	 COMPARE_HCNT_equ : CompareEQU generic map (10) port map
           (A       => Hcount,
            B       => "1100011111", ---799
            EQU     => RollH);
				
	 ----------CompareLES----------------
	 COMPARE_HCNT_les1 :CompareLES generic map (10) port map
           (A       =>  Hcount,
            B       =>  "1010010000", ---656
            LES     =>  Hactive);
				
   ----------CompareLES----------------
	 COMPARE_HNT3_les2 :CompareLES generic map (10) port map
           (A       => Hcount,
            B       =>  "1010000000", ---640
            LES     =>  H_LT656);
			
    ----------CompareGRT----------------
	 COMPARE_HNT3_grt :CompareGRT generic map (10) port map
           (A       =>   Hcount,
            B       =>  "1011101111", ---751
            GRT     =>   H_GT751);
				
     HoriCOUNT : Counter_nbit generic map (10) port map
	            ( EN    =>  Pulse_pixel,
		           CLK   =>  CLK,
				     CLR   =>  CLR_intX,
				      Q    =>  Hcount); 
						
	  X_out <= Hcount; 
 	  CLR_intX <= '1' when (RollH = '1' and Pulse_pixel = '1') else '0'; 

  ----------------------Vertical------------------------------------  	
    ----------CompareEQU----------------
	 COMPARE_VCNT_equ :CompareEQU generic map (10) port map
           (A       => Vcount,
            B       => "1000001100", ---524
            EQU     => RollV);
				
	 ----------CompareLES----------------
	 COMPARE_VCNT_les1 :CompareLES generic map (10) port map
           (A       =>  Vcount,
            B       =>  "0111100000", ---480
            LES     =>  Vactive);
				
   ----------CompareLES----------------
	 COMPARE_VNT3_les2 :CompareLES generic map (10) port map
           (A       =>  Vcount,
            B       =>  "0111101010", ---490
            LES     =>   V_LT490);
				

    ----------CompareGRT----------------
	 COMPARE_VNT3_grt :CompareGRT generic map (10) port map
           (A       =>   Vcount,
            B       =>   "0111101011", ---491
            GRT     =>   V_GT491);
				
    VertiCOUNT : Counter_nbit generic map (10) port map
	            ( EN    =>  EN_intV,
		           CLK   =>  CLK,
				     CLR   =>  CLR_intV,
				      Q    =>  Vcount); 
						
			---------OUTPUTS AND INPUTS-------			
       Y_out <= Vcount;  
 	    EN_intV	   <= RollH and Pulse_pixel ;   
 	    CLR_intV   <= RollH  and Pulse_pixel and RollV ; 

   
	  ----------------DflipFlops---------to send out the RGB Color and Blank it-------
	   
		D_intH   <= '1' when (H_LT656  = '1' or  H_GT751 = '1') else '0'; 
		D_intV   <= '1' when (V_LT490 = '1' or  V_GT491 = '1')else '0'; 
		R_Dff    <= '1' when (Vactive = '1' and Hactive = '1')else'0';
		
		  ---to choose somethinf-----
	     DFLIP_vsync  :    Dff_CE port map 
                  (D    => D_intH,
					    CE   => Pulse_pixel,
						 CLK  => CLK,
						 Q    => HSYNC);	
        ---to choose somethinf-----
        DFLIP_hsync  : Dff_CE port map 
                  (D    =>  D_intV,
					    CE   =>  Pulse_pixel,
						 CLK  =>  CLK,
						 Q    =>  VSYNC);
        
		 
       DFLIP_RGB    : Dff_CE port map 
                  (D    =>  R_Dff,
					    CE   =>  Pulse_pixel,
						 CLK  =>  CLK,
						 Q    =>  RGB_enable_Reg);
		-----this is the mux ---------			 
      RGB_out  <=  RGB_in  when (RGB_enable_Reg = '1') else x"000"; 
		             			 
end Behavioral;

