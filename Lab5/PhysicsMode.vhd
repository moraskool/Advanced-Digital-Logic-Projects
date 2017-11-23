 -- Entity:         PhysicsMode
-- Written By:      Morayo Ogunsina
-- Date Created:    11/9/2015
-- Description:     An LED train that triggers a bundle of LEDs to move 
--                  in a certain way when it hits it.Button Sequence  
--                  CENTER five times enters this mode,Displays "C".
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.

---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PhysicsMode is 
   Port (CLK			:	in STD_LOGIC;
			CLR			:	in STD_LOGIC; 
			EN        	:	in STD_LOGIC; 
			control_out :	out STD_LOGIC_VECTOR(15 downto 0));
end PhysicsMode;

architecture Behavioral of PhysicsMode is
    ----------all possible states--------------
type STATE_TYPE is (T0, T1, T2, T3,  T4, T5,  T6,
                    T7, T8, T9, T10, T11, T12, T13,
  						  T14, T15,	T16, T17);
	
	signal presentState : STATE_TYPE; 
	signal nextState	  : STATE_TYPE;
	
	---------decoder to choose which digit is displayed---------
	
	
	constant  ZERO: 		STD_LOGIC_VECTOR(15 downto 0) := "1000011111100000";	
	constant   ONE: 		STD_LOGIC_VECTOR(15 downto 0) := "0100011111100000";
	constant   TWO: 		STD_LOGIC_VECTOR(15 downto 0) := "0010011111100000";
	constant THREE: 		STD_LOGIC_VECTOR(15 downto 0) := "0001101111100000";
	constant  FOUR: 		STD_LOGIC_VECTOR(15 downto 0) := "0000111111100000";
	constant  FIVE: 		STD_LOGIC_VECTOR(15 downto 0) := "0000111111010000";
	constant   SIX: 		STD_LOGIC_VECTOR(15 downto 0) := "0000111111001000";
	constant SEVEN:		STD_LOGIC_VECTOR(15 downto 0) := "0000111111000100";
	constant EIGHT: 		STD_LOGIC_VECTOR(15 downto 0) := "0000111111000010";
	constant  NINE: 		STD_LOGIC_VECTOR(15 downto 0) := "0000111111000001";

	
begin
  ----sequential component----
process (CLK,CLR,EN)
	begin 
		if (CLR = '1') then 
			presentState <= T0;
		elsif (CLK'event and CLK = '1' and EN = '1') then 
			presentState <= nextState;
		end if; 
	end process; 
	
	---------------combinational component----------------
	process(presentState)
	begin 
		case presentState is 
	
-------------------right transistion----------------------------	
			when T0 => 
				control_out <= ZERO;
				nextState <= T1;

		----------------------------
			when T1 => 
				control_out <= ONE;
				nextState <= T2;
	
		-----------------------------		
			when T2 => 
				control_out <= TWO;
				nextState <= T3;
		
		-------------------------------	
			when T3 => 
				control_out <= THREE;
				nextState <= T4;
				
		------------------------------	
			when T4 => 
				control_out <= FOUR;
				nextState <= T5;
				
		------------------------------	
			when T5 => 
				control_out <= FIVE;
				nextState <= T6;	
				
		------------------------------
			when T6 => 
				control_out <= SIX;
				nextState <= T7;				
	
		-------------------------------	
			when T7 => 
				control_out <= SEVEN;
				nextState <= T8;	
				
		--------------------------------	
			when T8 => 
				control_out <= EIGHT;
				nextState <= T9;
					
		-------------------------------		
			when T9 => 
				control_out <= NINE;
				nextState <= T10;
					
		------------------------------	
	-------------------left transistion----------------------------
			when T10 => 
				control_out <= EIGHT;
				nextState <= T11;
					
		------------------------------	
			when T11 => 
				control_out <= SEVEN;
				nextState <= T12;
					
		------------------------------
				
			when T12 => 
				control_out <= SIX;
				nextState <= T13;
					
		------------------------------
				
			when T13 => 
				control_out <= FIVE;
				nextState <= T14;
					
		-------------------------------
			when T14 => 
				control_out <= FOUR;
				nextState <= T15;				
				

		-------------------------------	
			when T15 => 
				control_out <= THREE;
				nextState <= T16;	

		------------------------------
			when T16 => 
				control_out <= TWO;
				nextState <= T17;

		----------------------------
			when T17 => 
				control_out <= ONE;
				nextState <= T0;    ---start again from the first--
			
			end case; 
	end process;
end Behavioral;


