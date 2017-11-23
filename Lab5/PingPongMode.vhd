-- Entity:        PingPongMode
-- Written By:    Morayo Ogunsina
-- Date Created:  11/9/2015
-- Description:    An LED train that moves back  and forth bouncing,off 
--                 the ends.Button Sequence LEFT-CENTER-RIGHT-CENTER-LEFT 
--                 enters this mode, Displays "B".
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.

---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PingPongMode is
   Port (CLK			:	in STD_LOGIC;
			CLR			:	in STD_LOGIC; 
			EN        	:	in STD_LOGIC; 
			control_out :	out STD_LOGIC_VECTOR(15 downto 0));
end PingPongMode;

architecture Behavioral of PingPongMode is

            ---all possible states----
type STATE_TYPE is ( T0,  T1,  T2,  T3,  T4,  T5, T6,
                     T7,  T8,  T9,  T10, T11, T12, 
						   T13, T14, T15, T16, T17, T18,
						   T19, T20, T21, T22, T23, T24,
 							T25, T26, T27, T28, T29, T30, T31);
	
	signal presentState : STATE_TYPE; 
	signal nextState	  : STATE_TYPE;
	
	-----hex representation of led , one hot encoding--------
	constant  ZERO: 		STD_LOGIC_VECTOR(15 downto 0) := "1000000000000000";	
	constant   ONE: 		STD_LOGIC_VECTOR(15 downto 0) := "0100000000000000";
	constant   TWO: 		STD_LOGIC_VECTOR(15 downto 0) := "0010000000000000";
	constant THREE: 		STD_LOGIC_VECTOR(15 downto 0) := "0001000000000000";
	constant  FOUR: 		STD_LOGIC_VECTOR(15 downto 0) := "0000100000000000";
	constant  FIVE: 		STD_LOGIC_VECTOR(15 downto 0) := "0000010000000000";
	constant   SIX: 		STD_LOGIC_VECTOR(15 downto 0) := "0000001000000000";
	constant SEVEN:		STD_LOGIC_VECTOR(15 downto 0) := "0000000100000000";
	constant EIGHT: 		STD_LOGIC_VECTOR(15 downto 0) := "0000000010000000";
	constant  NINE: 		STD_LOGIC_VECTOR(15 downto 0) := "0000000001000000";
	constant     A: 		STD_LOGIC_VECTOR(15 downto 0) := "0000000000100000";
	constant     B: 		STD_LOGIC_VECTOR(15 downto 0) := "0000000000010000";
	constant     C: 		STD_LOGIC_VECTOR(15 downto 0) := "0000000000001000";
	constant     D: 		STD_LOGIC_VECTOR(15 downto 0) := "0000000000000100";
	constant     E: 		STD_LOGIC_VECTOR(15 downto 0) := "0000000000000010";
	constant     F: 		STD_LOGIC_VECTOR(15 downto 0) := "0000000000000001";

	
begin
    ---------------sequential logic----------------
 process (CLK, CLR, EN) ---make this an asynchronous state register
	begin 
		if (CLR = '1') then 
			presentState <= T0;
		elsif (CLK'event and CLK = '1' and EN = '1') then 
			presentState <= nextState;
		end if; 
	end process; 
	
	
	------------combinationl logic-----------
	    -------state 0------------
	process(presentState)
	begin 
	   case presentState is 
		
			when T0 => 
				control_out <= ZERO;
				nextState <= T1;

		--------state 1------------
			when T1 => 
				control_out <= ONE;
				nextState <= T2;
	
		---------state 2-------------		
			when T2 => 
				control_out <= TWO;
				nextState <= T3;
		
		--------state 3--------------	
			when T3 => 
				control_out <= THREE;
				nextState <= T4;
				
		---------state 4------------	
			when T4 => 
				control_out <= FOUR;
				nextState <= T5;
				
		---------state 5-------------	
			when T5 => 
				control_out <= FIVE;
				nextState <= T6;	
				
		---------state 6-----------
			when T6 => 
				control_out <= SIX;
				nextState <= T7;				
	
		---------state 7------------	
			when T7 => 
				control_out <= SEVEN;
				nextState <= T8;	
				
		--------state 8--------------	
			when T8 => 
				control_out <= EIGHT;
				nextState <= T9;
					
		-------state 9--------------		
			when T9 => 
				control_out <= NINE;
				nextState <= T10;
					
		-------state 10-------------		
			when T10 => 
				control_out <= A;
				nextState <= T11;
					
		------state 11-------------	
			when T11 => 
				control_out <= B;
				nextState <= T12;
					
		--------state 12--------------
				
			when T12 => 
				control_out <= C;
				nextState <= T13;
					
		----------state 13------------
				
			when T13 => 
				control_out <= D;
				nextState <= T14;
					
		----------state 14-------------
			when T14 => 
				control_out <= E;
				nextState <= T15;				
				

		--------state 15-------------	
			when T15 => 
				control_out <= F;
				nextState <= T16;	

		------------------------------
		--Count down---------state 16------------------------------------------------
			when T16 => 
				control_out <= F;
				nextState <= T17;

		------state 17------------
			when T17 => 
				control_out <= E;
				nextState <= T18;
	
		-------state 18------------		
			when T18 => 
				control_out <= D;
				nextState <= T19;
		
		--------state 19-------------	
			when T19 => 
				control_out <= C;
				nextState <= T20;
				
		--------state 20-----------	
			when T20 => 
				control_out <= B;
				nextState <= T21;
				
		--------state 21-------------	
			when T21 => 
				control_out <= A;
				nextState <= T22;	
				
		--------state 22------------
			when T22 => 
				control_out <= NINE;
				nextState <= T23;				
	
		-------state 23------------	
			when T23 => 
				control_out <= EIGHT;
				nextState <= T24;	
				
		------state 24------------	
			when T24 => 
				control_out <= SEVEN;
				nextState <= T25;
					
		-------state 25------------		
			when T25 => 
				control_out <= SIX;
				nextState <= T26;
					
		--------state 26------------		
			when T26 => 
				control_out <= FIVE;
				nextState <= T27;
					
		-------state 27-----------	
			when T27 => 
				control_out <= FOUR;
				nextState <= T28;
					
		-------state 28------------
				
			when T28 => 
				control_out <= THREE;
				nextState <= T29;
					
		-------state 28--------------
				
			when T29 => 
				control_out <= TWO;
				nextState <= T30;
					
		-------state 30-------------
			when T30 => 
				control_out <= ONE;
				nextState <= T31;				
				
		--------state 31--------------	
			when T31 => 
				control_out <= ZERO;
				nextState <= T0;	

		------------------------------
			end case; 
	end process;

end Behavioral;


