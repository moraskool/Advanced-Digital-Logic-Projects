
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;



entity Lab04_mao5270 is
  port (SWITCH  :  in STD_LOGIC_VECTOR(15 downto 0);
         BTNR   :  in STD_LOGIC;
			BTNL   :  in STD_LOGIC;
			BTNU   :  in STD_LOGIC;
			BTND   :  in STD_LOGIC;
			BTNC   :  in STD_LOGIC;
			CLK    :  in  STD_LOGIC; 
			ANODE  :  out STD_LOGIC_VECTOR(7 downto 0);
			SEGMENT:  out STD_LOGIC_VECTOR(0 to 6);
			LED    :  out STD_LOGIC_VECTOR(15 downto 0));
end Lab04_mao5270;

architecture Behavioral of Lab04_mao5270 is

   -- declare all internal signals
	 signal CLEAR_int : STD_LOGIC;
	 signal dff1_int  : STD_LOGIC;
	 signal dff2_int  : STD_LOGIC;
	 signal pulse16   : STD_LOGIC;
	 signal pulse50m  : STD_LOGIC;
	 signal pulse500  : STD_LOGIC;
	 signal pulse1000 : STD_LOGIC;
	 signal Oneshot_up: STD_LOGIC;
	 signal OneShot_dwn : STD_LOGIC;
	 signal OneShot_int : STD_LOGIC;
	 signal OneShot_reg : STD_LOGIC;
	 signal DB_int    : STD_LOGIC;
	 signal DB_up     : STD_LOGIC;
	 signal DB_down   : STD_LOGIC;
	
	 signal MX_oupt   : STD_LOGIC_VECTOR(3 downto 0);
	 signal SEL_int   : STD_LOGIC_VECTOR(2 downto 0);
	 signal  Q_intW   : STD_LOGIC_VECTOR(2 downto 0);
	 signal  Q_intSH  : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Qq       : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Oupt0    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Oupt1    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Oupt2    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Oupt3    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Oupt4    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Oupt5    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Oupt6    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Oupt7    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  Grand    : STD_LOGIC_VECTOR(15 downto 0);
	 signal  WORD     : STD_LOGIC_VECTOR(31 downto 0);
	 
	 ------to clear the counter,use this---  
		constant maxCount: integer := 8; 
 
 
begin
----------------------------------------DFLIP FLOPS----------------------------------------------- 
      DFF1: DFFCLK_ENABLE  port map
		     (D   => BTNU, 
				CLK => CLK, 
				Q   => dff1_int); 
 				 
 	  DFF2: DFFCLK_ENABLE port map
	        (D   => dff1_int, 
				CLK => CLK, 
 				Q   => dff2_int); 

----------------------------------------PULSE GENERATORS----------------------------------------------- 
    ----------16 HZ pulse generator----------------------- 
		P16M : PulseGenerator generic map (23,6250000) port map
	        (EN       => '1',
	         CLK      => CLK,
            CLR      => '0',
            PULSE    => pulse16);
				
	----------50 MHZ pulse generator-----------------------							
     P50M : PulseGenerator generic map (32,2) port map
	        (EN       => '1',
	         CLK      => CLK,
            CLR      => '0',
            PULSE    => pulse50m);	
				
	----------500 HZ pulse generator-----------------------	
	P500: PulseGenerator generic map ( 
			n        => 18, 
 			maxCount => 200000) port map    
		  ( EN  	     => '1',     
			CLK 	     => CLK,	 
			CLR 		  => '0',	 
			PULSE      => pulse500);	
				
   ----------1000 HZ pulse generator-----------------------	
	P1000: PulseGenerator generic map ( 
			n        => 17, 
 			maxCount => 104000) port map    
		  ( EN  	     => '1',     
			CLK 	     => CLK,
         CLR 		  => '0',			
			PULSE 	  => pulse1000);	
			
	----------------------------------------DEBOUNCERS----------------------------------------------- 
         --Debouncer
	   DEB_up      : Debouncer port map  (
		     D       =>  BTNU, 
			  SAMPLE  =>  pulse500, 
			  CLK     =>  CLK,   
			  Q       =>  DB_up);
			 
			   --Debouncer
	  DEB_down    : Debouncer port map  (
		     D       =>  BTND, 
			  SAMPLE  =>  pulse500, 
			  CLK     =>  CLK,   
			  Q       =>  DB_down);		

			   --Debouncer
	  DEB_int    : Debouncer port map  (
		     D       =>  BTNC, 
			  SAMPLE  =>  pulse1000, 
			  CLK     =>  CLK,   
			  Q       =>  DB_int);			  
	
   ----------------------------------------ONESHOTS----------------------------------------------- 	
			  
            --OneShot
     	 ONESHT_up  : OneShot port map (
		      D      =>  DB_up,  
			   CLK    =>  CLK,
			   Q      =>  OneShot_up);
				
				--OneShot
	   ONESHT_down  : OneShot port map (
		      D      =>  DB_down, 
			   CLK    =>  CLK, 
			   Q      =>  OneShot_dwn);
            
				--OneShot
      ONESHT_int  : OneShot port map (
		      D      =>  DB_int,  
			   CLK    =>  CLK,
			   Q      =>  OneShot_int);	

           --OneShot
      ONESHT_reg  : OneShot port map (
		      D      =>  dff2_int,  
			   CLK    =>  CLK,
			   Q      =>  OneShot_reg);				
   ----------------------------------------REGISTERS----------------------------------------------- 
	
   -- Register 0-----------------------------------------------------------------------------------
  process (CLK)	
	 begin  
	       if(CLK 'event and CLK ='1') then
			    if(OneShot_int = '1')then
	             Q_intSH <= SWITCH(0) & Q_intSH(15 downto 1);	 
			   end if;
	       end if;	 
  end process ;
                 LED    <= Q_intSH;
	              Oupt0  <= Q_intSH;   
      
	-- Register 1-----------------------------------------------------------------------------------			
	  RG16 : Counter_nbit generic map(16) port map    
		    ( EN     =>  pulse16, 
			   CLK    =>  CLK, 
			   CLR    =>  BTNR, 
			   Q      =>  Oupt1);
	
	-- Register 2-----------------------------------------------------------------------------------			
	     --instantiate the Counter_nbit
     RG50 : Counter_nbit generic map(16) port map    
		    ( EN     =>  pulse50m, 
			   CLK    =>  CLK, 
			   CLR    =>  BTNR, 
			   Q      =>  Oupt2);
	
	-- Register 3-----------------------------------------------------------------------------------	
	  RAND : Register_nbit generic map(16)  port map 
	         (D     =>  Oupt2, 
		      LOAD   =>  BTNL,
		      CLK    =>  CLK,
				CLR    =>  BTNR,
				Q      =>  Oupt3);
	
	-- Register 4-----------------------------------------------------------------------------------
	  REG4 : Counter_nbit generic map(16) port map (
				EN     => BTNU,
		      CLK    => CLK,
				CLR    => BTNR,
				Q      => Oupt4);
	
	-- Register 5-----------------------------------------------------------------------------------
	  REG5 : Counter_nbit generic map(16) port map (
				EN     => OneShot_reg,
		      CLK    => CLK,
				CLR    => BTNR,
				Q      => Oupt5);
	
	-- Register 6 ------------------------------------------------------------------------------------
	  REG6 : Counter_nbit generic map (16) port map (
				EN    => OneShot_up,
		      CLK   => CLK,
				CLR   => BTNR,
				Q     => Oupt6);
				
	-- Register 7 ------------------------------------------------------------------------------------
	  REG7 : CounterUpDown_nbit generic map (16) port map (
	         EN    => '1',
		      UP    => OneShot_up,
		      DOWN  => OneShot_Dwn,
		      CLK   => CLK,
				CLR   => BTNR,
			   Q     => Oupt7);
		  
 
	--compare if equal to 7 for the clock counter 
 	CLEAR_int <= '1' when (to_integer(unsigned(Q_intW)) = maxCount) else  
 					 '1' when (BTNR = '1') else 
 					 '0';  
		
    -------word to hex segment-------
	
   --for the anode--
      -- instantiate the Decoder3to8 component
   DECD: Decoder3to8 port map (
	       X   => Q_intW,
		    EN  => "10001111",
		    YD  => ANODE);
			 
	   -- instantiate the Counter_nbit Component	
	 WRD_COUNTER : Counter_nbit generic map(3) port map (
		      EN     =>  pulse1000,
			   CLK    =>  CLK, 
			   CLR    =>  CLEAR_int, 
			   Q      =>  Q_intW);		 
			
 -------output goes to HexToSevenSeg ------		
	  ----instantiate the Mux_4to1 generic component
	  MUX_OutputWRD:  Mux4to1 generic map(4) port map(
		   X0     => WORD(3 downto 0),
         X1     => WORD(7 downto 4),
         X2     => WORD(11 downto 8),
         X3     => WORD(15 downto 12),
			X4     => WORD(19 downto 16),
			X5     => WORD(23 downto 20),
			X6     => WORD(27 downto 24),
			X7     => WORD(31 downto 28),
         SEL    => Q_intW,
         Y      => MX_oupt);
				
	 ------instantiate the HexToSevenSeg Component	
	 HEX2:  HexToSevenSeg port map (
           HEX      => MX_oupt,
			  SEGMENT  => SEGMENT);
			  
-------chooses which register to display ------		
	  ----instantiate the Mux_4to1 generic component
	  MUX_OutputREG:  Mux4to1 generic map(16) port map(
		   X0     => Oupt0,
         X1     => Oupt1,
         X2     => Oupt2,
         X3     => Oupt3,
			X4     => Oupt4,
			X5     => Oupt5,
			X6     => Oupt6,
			X7     => Oupt7,
         SEL    => SWITCH(15 downto 13),
         Y      => Grand);			  
		
    WORD (31)            <= '0';  -- just 0	
    WORD (30 downto 28)  <= SWITCH(15 downto 13); -- to display the corresponding register number	
    WORD (27 downto 16)  <= (OTHERS => '0'); --blank digits	
    WORD (15 downto 0)   <= Grand;  -- to choose which register to display
	 
	 
end Behavioral;

