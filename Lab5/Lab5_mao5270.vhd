----------------------------------------------------------------------------
-- Entity:          Lab5_mao5270
-- Written By:      Morayo Ogunsina
-- Date Created:    11/9/2015
-- Description:     Top Level HDL, displays registers with various 
--                  functions and the register number
-- Revision History (date, initials, description):

-- Dependencies:
--		Dff_CE.
--    PulseGenerator
--    Debouncer
--    OneShot
--    Counter_nbit
--    CounterUpDown_nbit
--    Mux4to1
--    HexToSevenSeg
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;


entity Lab5_mao5270 is
   port (CLK			:	in  STD_LOGIC;
	      SWITCH      :  in  STD_LOGIC_VECTOR (0 to 15);
         SEGMENT     :	out STD_LOGIC_VECTOR (0 to 6);			
 			BUTTON      :  in  STD_LOGIC_VECTOR (4 downto 0);  
 			ANODE       :	out STD_LOGIC_VECTOR (7 downto 0); 
 			LED         :	out STD_LOGIC_VECTOR (15 downto 0)); 
end Lab5_mao5270;

architecture Behavioral of Lab5_mao5270 is
   

  -- Pulse generator signals 
	signal Pulse_int            : STD_LOGIC; 
	signal PulseFast_int        : STD_LOGIC;
   signal PulseWall_int        : STD_LOGIC;	
	signal pulse2secs           : STD_LOGIC;  
   signal PulsePingPong_int    : STD_LOGIC; 	
	
	-- One shot signals 
	signal OneSht_BTNR			 : STD_LOGIC;
	signal OneSht_BTNL			 : STD_LOGIC;
	signal OneSht_BTNC		    : STD_LOGIC;
	signal OneSht_BTNU		    : STD_LOGIC;
	signal OneSht_BTND		    : STD_LOGIC;
	
	-- Debouncer signals 
	signal DB_BTNR				    : STD_LOGIC;
	signal DB_BTND				    : STD_LOGIC;
	signal DB_BTNL				    : STD_LOGIC;
	signal DB_BTNC				    : STD_LOGIC;
	signal DB_BTNU				    : STD_LOGIC;
	
	--signals for FSMs
	signal STATUS_in_int        :STD_LOGIC_VECTOR(4 downto 0); 
	signal CONTROL_out_int      :STD_LOGIC_VECTOR(4 downto 0); 
	signal CONTROL_out_train    :STD_LOGIC_VECTOR(15 downto 0);
	signal CONTROL_out_Wall     :STD_LOGIC_VECTOR(15 downto 0);
	signal CONTROL_out_Physics  :STD_LOGIC_VECTOR(15 downto 0);
	signal CONTROL_out_PingPong :STD_LOGIC_VECTOR(15 downto 0);
	
	signal Hex_int              : STD_LOGIC_VECTOR(31 downto 0); 	
	signal simul3Clear 		    : STD_LOGIC;
	 
	--signal CLR : STD_LOGIC:= '0';
	
	
	alias BTNL  is BUTTON(0); 
	alias BTNR  is BUTTON(1); 
	alias BTNC  is BUTTON(2); 
	alias BTNU  is BUTTON(3); 
	alias BTND  is BUTTON(4); 
	
	--------------------DECLARE ALL FSMs---------------
	component FSM_off is
      port ( CLK         : in  STD_LOGIC;
             CLR         : in  STD_LOGIC;
             STATUS_in   : in  STD_LOGIC_VECTOR (4 downto 0);
             CONTROL_out : out STD_LOGIC_VECTOR (4 downto 0));
   end component;
	
	------PingPongMode Component-----
	component PingPongMode is
   Port (CLK			:	in STD_LOGIC;
			CLR			:	in STD_LOGIC; 
			EN        	:	in STD_LOGIC; 
			control_out :	out STD_LOGIC_VECTOR(15 downto 0));
   end component;
	
	-----PhysicsMode component-------
	component PhysicsMode is 
   Port (CLK			:	in STD_LOGIC;
			CLR			:	in STD_LOGIC; 
			EN        	:	in STD_LOGIC; 
			control_out :	out STD_LOGIC_VECTOR(15 downto 0));
  end component;
  
  ------WallMode_FSM  component
  component WallMode_FSM is
   Port (CLK			:	in STD_LOGIC;
			CLR			:	in STD_LOGIC; 
			EN        	:	in STD_LOGIC; 
			STATUS_in 	:  in STD_LOGIC_VECTOR(15 downto 0);
			control_out :	out STD_LOGIC_VECTOR(15 downto 0));
  end component;
  
  --------TrainMode Component----- 
  component TrainMode_FSM is
   port(CLK			   :	in STD_LOGIC;
	      EN          :  in STD_LOGIC;
			CLR			:	in STD_LOGIC; 
			control_out :	out STD_LOGIC_VECTOR(15 downto 0));
  end component;

  -------DataPath Component --------
   component DataPath is
    port  (CLK      			: in  STD_LOGIC;
		     CLR      			: in  STD_LOGIC;
		     STROBE   			: in  STD_LOGIC;
		     CONTROL_out     : in  STD_LOGIC_VECTOR(4  downto 0);
	        TrainMode_FSM 	: in  STD_LOGIC_VECTOR(15 downto 0);
	        PingPongMode 	: in  STD_LOGIC_VECTOR(15 downto 0);
	        PhysicsMode 		: in  STD_LOGIC_VECTOR(15 downto 0);
	        WallMode_FSM 	: in  STD_LOGIC_VECTOR(15 downto 0);
	        SEGMENT  			: out STD_LOGIC_VECTOR(0 to 6); 
	        ANODE    			: out STD_LOGIC_VECTOR(7 downto 0);
	        LED      			: out STD_LOGIC_VECTOR(15 downto 0));
   end component;
    
	 begin
	 
	STATUS_in_int(4) <= OneSht_BTNL;
	STATUS_in_int(3) <= OneSht_BTNR;
	STATUS_in_int(2) <= OneSht_BTNC;
	STATUS_in_int(1) <= OneSht_BTNU;
	STATUS_in_int(0) <= OneSht_BTND;
	

	-- simuultaneous Button CLEAR 
	simul3Clear <= (BTNR and BTNL and BTND); 
	
	--------Debouncer  component instantiation-------------- 
	DBL: Debouncer --left
		port map (D      => BTNL,
				    SAMPLE => pulse_int,
				    CLK    => CLK,
				    Q      => DB_BTNL);
					 
	DBR: Debouncer --right
		port map (D      => BTNR,
				    SAMPLE => pulse_int,
				    CLK    => CLK,
				    Q      => DB_BTNR);
	
	DBC: Debouncer --center
		port map (D      => BTNC,
				    SAMPLE => pulse_int,
				    CLK    => CLK,
				    Q      => DB_BTNC);
					 
	DBU: Debouncer  --up
		port map (D      => BTNU,
				    SAMPLE => pulse_int,
				    CLK    => CLK,
				    Q      => DB_BTNU);
					 
	DBD: Debouncer  --down
		port map (D      => BTND,
				    SAMPLE => pulse_int,
				    CLK    => CLK,
				    Q      => DB_BTND);
					 
	----------OneShot- component instantiation------------- 			 
	OSL: oneShot --left
	port map (D   => DB_BTNL,
			    CLK => CLK ,
			    Q   => OneSht_BTNL);				 

	OSR: oneShot  --right
	port map (D   => DB_BTNR,
			    CLK => CLK ,
			    Q   => OneSht_BTNR);
				 
			 
	OSC: oneShot  --center
	port map (D   => DB_BTNC,
			    CLK => CLK ,
			    Q   => OneSht_BTNC);
				 
	 			 
	OSU: oneShot -- up
	port map (D   => DB_BTNU,
			    CLK => CLK ,
			    Q   => OneSht_BTNU);
				 
			 
	OSD: oneShot --down
	port map (D   => DB_BTND,
			    CLK => CLK ,
			    Q   => OneSht_BTND);
				 
	--------PulseGenerator---component---------------------
	
	pulse: PulseGenerator  -- 10kHz clock,100micro secs
	generic map (n         => 16,
				    maxCount  => 10000 )
	port map    (EN  =>  '1',      
				    CLK =>	CLK,	 
				    CLR =>	'0',	 
				    PULSE => pulse_int);
					 
	pulseFast: PulseGenerator 
	generic map (n         => 20,
				    maxCount  => 104000 )
	port map    (EN  =>  '1',      
				    CLK =>	CLK,	 
				    CLR =>	'0',	 
					 PULSE => pulseFast_int);
					 
					 
	pulseTrain: PulseGenerator --5Hz clock, 0.2s			 
	generic map (n         => 27,
				    maxCount  => 20000000)
	port map    (EN  =>  '1',      
				    CLK =>	CLK,	 
				    CLR =>	'0',	 
					 PULSE => pulse2secs);
					 
	pulsePingPong: PulseGenerator  ---1Hz clock, 1s
	generic map (n         => 25,
				    maxCount  => 6250000)
	port map    (EN  =>  '1',      
				    CLK =>	CLK,	 
				    CLR =>	'0',	 
					 PULSE => pulsePingPong_int);
					 
	------------FSMS Components-------------------
	FSM0: FSM_off
	Port map (CLK		    =>  CLK,		
				 CLR		    =>  simul3Clear,
			    STATUS_in   =>  STATUS_in_int,  
			    CONTROL_out =>  CONTROL_out_int); 
				 
	FSM1: TrainMode_FSM
	Port map (CLK		    =>  CLK,		
				 CLR		    =>  '0',
				 EN          =>  pulse2secs,
			    CONTROL_out =>  CONTROL_out_Train);
			
	FSM2: PingPongMode 
	Port map (CLK	 		 => CLK,		
				 CLR	 		 => '0',	
				 EN     		 => pulsePingPong_int,  	
				 control_out => CONTROL_out_PingPong);
				 
	FSM3: PhysicsMode 
	Port map (CLK			 => CLK,
				 CLR			 => '0',
			    EN        	 => pulse2secs,
			    control_out => CONTROL_out_Physics);
				 
	FSM4: WallMode_FSM 
	Port map (CLK			 => CLK,
				 CLR			 => '0',
				 STATUS_in	 => SWITCH,
			    EN        	 => pulse2secs,
			    control_out => CONTROL_out_Wall);
				 
	----------------DataPath Component------------------------------------
	
	DATA: DataPath 
	port map (CLK      		=> CLK,
				 CLR      		=>	'0',
				 SEGMENT  		=>	SEGMENT,
	          ANODE    		=>	ANODE,
	          LED      		=>	LED,
				 STROBE   		=>	PulseFast_int,
				 CONTROL_out   => CONTROL_out_int,
				 WallMode_FSM 	=>	CONTROL_out_Wall,  
				 TrainMode_FSM =>	CONTROL_out_Train,
				 PhysicsMode 	=>	CONTROL_out_Physics,
				 PingPongMode 	=>	CONTROL_out_PingPong);

end Behavioral;

