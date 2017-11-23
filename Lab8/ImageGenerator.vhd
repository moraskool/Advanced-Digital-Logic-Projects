----------------------------------------------------------------------------
-- Entity:         ImageGenerator
-- Written By:     Morayo Ogunsina
-- Date Created:   10/26/2015
-- Description:    Functionally generates the image described in the functional
--                 space.The X and Y inputs determine which pixel of the image to  
--                 output.The switches determine the color of the pixel.The 
--                 buttons are used to move the square.
-- Revision History (date, initials, description):
--    Dependencies:
--		PulseGenerator
--    Counter_nbit
--    CounterUpDown_nbit
--    Comparator  : CompareLES,CompareEQU,CompareGRT
---------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity ImageGenerator is
 port     (BUTTON  : in  STD_LOGIC_VECTOR(0 to 4);
			  RGB_in  : in  STD_LOGIC_VECTOR(11 downto 0);    
			  X_in    : in  STD_LOGIC_VECTOR(9 downto 0);
	        Y_in    : in  STD_LOGIC_VECTOR(9 downto 0);
			  CLK     : in  STD_LOGIC;
			  RGB_out : out STD_LOGIC_VECTOR(11 downto 0));
 end ImageGenerator;

architecture Behavioral of ImageGenerator is
    --------internal signal--------
	 
signal XLES 				  : STD_LOGIC;  --compare signals for borders
signal XGRT 				  : STD_LOGIC;
signal YLES 				  : STD_LOGIC;
signal YGRT 				  : STD_LOGIC;
signal CountRight		     : STD_LOGIC;  --signals for all comparitors
signal CountLeft		     : STD_LOGIC;
signal CountUp		     	  : STD_LOGIC;
signal CountDown		     : STD_LOGIC;
signal LeftBorder			  : STD_LOGIC;   --detect borders
signal RightBorder		  : STD_LOGIC;
signal UpBorder			  : STD_LOGIC;
signal DownBorder			  : STD_LOGIC; 
signal XLesBox	 			  : STD_LOGIC;
signal XGrtBox	 			  : STD_LOGIC;
signal YLesBox	 			  : STD_LOGIC;
signal YGrtBox	 			  : STD_LOGIC;
signal INBox	 			  : STD_LOGIC;
signal DB_BTNR 			  : STD_LOGIC;   --debounce signals for buttons
signal DB_BTNL 			  : STD_LOGIC;
signal DB_BTNU 			  : STD_LOGIC;
signal DB_BTND 			  : STD_LOGIC;
signal pulse_int          : STD_LOGIC;
signal pulse_sample       : STD_LOGIC;
signal UpDwnX_int 		  : STD_LOGIC_VECTOR(9 downto 0); ---counter signals for box movement
signal UpDwnY_int 		  : STD_LOGIC_VECTOR(9 downto 0); 
signal sumX_intRgt 		  : STD_LOGIC_VECTOR(9 downto 0); --RCA_signals
signal sumX_intLft 		  : STD_LOGIC_VECTOR(9 downto 0);
signal sumY_intUp 		  : STD_LOGIC_VECTOR(9 downto 0);
signal sumY_intDwn 		  : STD_LOGIC_VECTOR(9 downto 0);
alias BTNL                : STD_LOGIC is BUTTON(0); --- button signals
alias BTNR                : STD_LOGIC is BUTTON(1);
alias BTNU                : STD_LOGIC is BUTTON(2);
alias BTND                : STD_LOGIC is BUTTON(3);
alias BTNC                : STD_LOGIC is BUTTON(4);
begin
	
	----------------------Draw the Borders---------------------------------------
	BORDERX_LES: CompareLES
		generic map(N => 10) port map	 
            		(A	   => X_in,	
						B	   => "0000001010", --10	
						LES   => XLES);
					
	BORDERX_GRT: CompareGRT
		generic map(N => 10) port map	 
            		(A	   => X_in,	
						B	   => "1001110110" ,	--630
						GRT   => XGRT);
						
	BORDERY_LES: CompareLES
		generic map(N => 10) port map	 
            		(A	   => y_in,	
						B	   => "0000001010",--10
						LES   => YLES);
					
	BORDERY_GRT: CompareGRT
		generic map(N => 10) port map	
            		(A	   => Y_in,	
						B	   => "0111010110",	--470
						GRT   => YGRT);
	
	----------------------Draw a small BOX---------------------------------------
	---------Debounce all your buttons ------------
	DEBOUNCE_R: Debouncer port map
	           (D			=> BTNR,     
					SAMPLE   => pulse_int,
					CLK      => CLK,
					Q        => DB_BTNR);
					
	DEBOUNCE_L: Debouncer port map
	            (D			=> BTNL,     
					SAMPLE   => pulse_int,
					CLK      => CLK,
					Q        => DB_BTNL);
					
	DEBOUNCE_U: Debouncer port map
	           (D			=> BTNU,     
					SAMPLE   => pulse_int,
					CLK      => CLK,
					Q        => DB_BTNU);
					
	DEBOUNCE_D: Debouncer
		port map(D			=> BTND,     
					SAMPLE   => pulse_int,
					CLK      => CLK,
					Q        => DB_BTND);
					
	PULSE1 : PulseGenerator 
		generic map (20, 1000000)	port map 
           	(EN    	    => '1',
				 CLK   	    => CLK,
				 CLR  		 => '0',
				 PULSE       => pulse_int);
					 
	-- X component of Box----------------- 
	--when moving horizontally with the button
	CountRight <= DB_BTNR and RightBorder;
	CountLeft  <= DB_BTNL and LeftBorder;
	
	UpDwn_X: CounterUpDown_nbit
		 generic map(n      => 10)
		 port map   (EN 	  => pulse_int,	
						 UP 	  => CountRight,
					    DOWN	  => CountLeft,
						 CLK 	  => CLK,
						 CLR 	  => '0',
						 Q 	  => UpDwnX_int);
						 
	RCAX_RIGHT: RippleCarryAdder_4bit 
			  generic map(N => 10) 
			  port map	 (A	  => SUMX_intLft,	
							  B	  => "0000010000", --272	
							  C_in  => '0',
							  C_out => open, 
							  SUM	  => SUMX_intRgt);
							  
							  
	RCAX_LEFT: RippleCarryAdder_4bit 
			  generic map(N => 10) 
			  port map	 (A	  => UpDwnX_int,	
							  B	  => "0100101100", --300	
							  c_in  => '0',
							  c_out => open, 
							  SUM	  => SUMX_intLft);
							  
	RightBox: CompareLES
		generic map(N => 10) 
		port map	  (A	   => X_in,	
						B	   => SUMX_intRgt,	
						LES   => XLesBox);
					
	LeftBox: CompareGRT
		generic map(N => 10) 
		port map	  (A	   => X_in,	
						B	   => SUMX_intLft,	
						GRT   => XGrtBox);
											
	-- Y component of box -------------------	
   --when moving vertically with the up down button	
	CountUp	 <= DB_BTNU and UpBorder;
	CountDown <= DB_BTND and DownBorder;
	
	UpDwn_Y: CounterUpDown_nbit
		 generic map(n      => 10)
		 port map   (EN 	  => pulse_int,	
						 UP 	  => CountDown,
					    DOWN	  => CountUp,
						 CLK 	  => CLK,
						 CLR 	  => BTNC,
						 Q 	  => UpDwnY_int);
						 			  
	RCAYU: RippleCarryAdder_4bit 
			  generic map(N => 10) 
			  port map	 (A	  => "0000010000", ---16
							  B	  => SUMY_intUp,	
							  c_in  => '0',
							  c_out => open, 
							  SUM	  => SUMY_intDwn);
	
	RCAYD: RippleCarryAdder_4bit 
			  generic map(N => 10) 
			  port map	 (A	  => "0011011100", --988	
							  B	  => UpDwnY_int,	
							  c_in  => '0',
							  c_out => open, 
							  SUM	  => SUMY_intUp);
							  
	DownBox: CompareLES
		generic map(N => 10) 
		port map	  (A	   => y_in,	
						B	   => SUMY_intDwn,	
						LES   => YLesBox);
					
	UpBox: CompareGRT
		generic map(N => 10) 
		port map	  (A	   => Y_in,	
						B	   => SUMY_intUp,	
						GRT   => YGrtBox);
	
-- compare box movement to know when it gets to boarder on x-axis -------
	BorderLeft: CompareGRT
		generic map(N => 10) 
		port map	  (A	   => SUMX_intLft,	
						B	   => "0000001001" ,	--9
						GRT   => LeftBorder);
						
	BorderRight: CompareLES
		generic map(N => 10) 
		port map	  (A	   => SUMX_intRgt,	
						B	   => "1001110111" ,	--631
						LES   => RightBorder);	
	-- compare box movement to know when it gets to boarder on y axis -------
	BorderUp: compareGRT
		generic map(N => 10) 
		port map	  (A	   => SUMY_intUp,	
						B	   => "0000001001" ,	--9
						GRT   => UpBorder);
						
	BorderDown: CompareLES
		generic map(N => 10) 
		port map	  (A	   => SUMY_intDwn,	
						B	   => "0111010111" ,	--471
						LES   => DownBorder);
						
	-- AND all box comparitors  ----
	INBoX <= XLesBox and XGrtBox and YLesBox and YGrtBox; 
	RGB_out <= NOT RGB_in when (  XLES = '1' OR XGRT='1' OR YGRT='1' OR YLES='1' or INBoX = '1') else 
					RGB_in;
				
end Behavioral;


