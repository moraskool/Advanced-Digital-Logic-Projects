
-- Entity:        TrainMode
-- Written By:    Morayo Ogunsina
-- Date Created:  9/2/2015
-- Description:    A train of 10 LEDs enters the left side an exits the right side,
--                 moving one LED every 0.2 seconds Button Sequence  
--                  CENTER five times enters this mode,Displays "A".
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.

---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TrainMode_FSM is
    port(CLK			:	in STD_LOGIC;
	      EN          :  in STD_LOGIC;
			CLR			:	in STD_LOGIC; 
			control_out :	out STD_LOGIC_VECTOR(15 downto 0));
end TrainMode_FSM;

architecture Behavioral of TrainMode_FSM is

      ---all possible states----
	type STATE_TYPE is (Tr0,  Tr1,  Tr2,  Tr3,  Tr4,  Tr5, Tr6,
                       Tr7,  Tr8,  Tr9,  Tr10, Tr11, Tr12,  
							  Tr13, Tr14, Tr15, Tr16, Tr17, Tr18,
							  Tr19, Tr20, Tr21, Tr22, Tr23, Tr24,Tr25);
	
	signal presentState : STATE_TYPE; 
	signal nextState	  : STATE_TYPE;

begin
 ----sequential logic------
  process (CLK,CLR)
	begin 
		if (CLR = '1') then 
			presentState <= Tr0;
		elsif (CLK'event and CLK = '1' and EN = '1') then 		
			      presentState <= nextState;
     end if	;	
	end process; 
	
	
	-----combinationl logic-------
	    
	process(presentState)
	begin 
		case presentState is 
			 ------state 0------
			when T0 => 
				control_out <= "1000000000000000";
				nextState   <= T1;
				
			 ------state 1------
			when T1 => 
				control_out <= "1100000000000000";
				nextState   <= T2;
				
			 ------state 2------
			when T2 => 
				control_out <= "1110000000000000";
				nextState   <= T3;
			
			  ------state 3------
			when T3 => 
				control_out <= "1111000000000000";
				nextState   <= T4;
			
			 ------state 4------
			when T4 => 
				control_out <= "1111100000000000";
				nextState   <= T5;
			
			 ------state 5------
			when T5 => 
				control_out <= "1111110000000000";
				nextState   <= T6;
			
			 ------state 6------
			when T6 => 
				control_out <= "1111111000000000";
				nextState   <= T7;
			
			 ------state 7------
			when T7 => 
				control_out <= "1111111100000000";
				nextState   <= T8;
			
			 ------state 8------
			when T8 => 
				control_out <= "1111111110000000";
				nextState   <= T9;
				
			 ------state 9------
			when T9 => 
				control_out <= "1111111111000000";
				nextState   <= T10;
			
			 ------state 10------
			when T10 => 
				control_out <= "0111111111100000";  --when it reaches the 10th lead
				nextState   <= T11;
				
				 ------state 11------
			when T11 => 
				control_out <= "0011111111110000";
				nextState   <= T12;
				
			 ------state 12------
			when T12 => 
				control_out <= "0001111111111000";
				nextState   <= T13;
				
			 ------state 13------
			when T13 => 
				control_out <= "0000111111111100";
				nextState   <= T14;
				
			 ------state 14------
			when T14 => 
				control_out <= "0000011111111110";
				nextState   <= T15;
				
			 ------state 15------
			when T15 => 
				control_out <= "0000001111111111";
				nextState   <= T16;
				
			 ------state 16------
			when T16 => 
				control_out <= "0000000111111111";
				nextState   <= T17;
				
			 ------state 17------
			when T17 => 
				control_out <= "0000000011111111";
				nextState   <= T18;
				
			 ------state 18------
			when T18 => 
				control_out <= "0000000001111111";
				nextState   <= T19;
				
			 ------state 19------
			when T19 => 
				control_out <= "0000000000111111";
				nextState   <= T20;
			
			 ------state 20------
			when T20 => 
				control_out <= "0000000000011111";
				nextState   <= T21;
			
          ------state 21------			
			when T21 => 
				control_out <= "0000000000001111";
				nextState   <= T22;
			
          ------state 22------  			
			when T22 => 
				control_out <= "0000000000000111";
				nextState   <= T23;
				
			 ------state 23------
			when T23 => 
				control_out <= "0000000000000011";
				nextState   <= T24;
				
			 ------state 24------
			when T24 => 
				control_out <= "0000000000000001";
				nextState   <= T25; 
				
			 ------state 25------
		   when T25 =>
			   control_out <= "0000000000000000";
				nextState   <= T0;	---go to the first LED
			end case; 
	end process;
end Behavioral;


