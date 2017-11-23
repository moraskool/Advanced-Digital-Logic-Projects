 
-- Entity:         FSM_off
-- Written By:     Morayo Ogunsina
-- Date Created:   11/9/2015
-- Description:    LED displays switch values,Button Sequence
--                 LEFT-DOWN-RIGHT enters this modeDisplays "0".
-- Revision History (date, initials, description):
-- 
-- Dependencies:
--		None.

---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
Library MAO5270_Library;
use MAO5270_Library.MAO5270_Components.all;

entity FSM_off is
  port ( CLK         : in  STD_LOGIC;
         CLR         : in  STD_LOGIC;
         STATUS_in   : in  STD_LOGIC_VECTOR (4 downto 0);
         CONTROL_out : out STD_LOGIC_VECTOR (4 downto 0));
end FSM_off;

architecture Behavioral of FSM_off is
       ---L = LEFT 
		 ---C = CENTER
		 ---R = RIGHT
		 ---U = UP
		 ---D = DOWN
	    
           type STATE_TYPE is (OFF, L,  LU,  LC,   LUR, 
			                      LCL, LCR,LCRC,LCRCL, C1,
										 C2,  C3, C4,  C5,   Invalid);
	
	signal presentState : STATE_TYPE; 
	signal nextState	  : STATE_TYPE;

begin
	 -----------sequential logic-----------
	process (CLK,CLR)
	begin 
		if (CLR = '1') then 
			presentState <= Off;
		elsif (CLK'event and CLK = '1') then 
			presentState <= nextState;
		end if; 
	end process; 
	
	---------------combinational logic----------------
	process(presentState, STATUS_in, CLR)
	begin 
		case presentState is 
			
			when Invalid => 
				control_out <= "00000";
				
				if(STATUS_in= "10000") then 
					nextState <= L;
					
				elsif(STATUS_in = "00100") then
					nextState <= C1;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
				
				 
				else 
					nextState <= Invalid;
			
				end if; 
				
			when OFF => 
				control_out <= "10000";
				
				if(STATUS_in= "10000") then 
					nextState <= L;
					
				elsif(STATUS_in = "00100") then
					nextState <= C1;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
				
				else 
					nextState <= Invalid;
			
				end if; 
		 --------------------------			
				when L => 
				control_out <= "00000";
				
				if(STATUS_in = "00010") then 
					nextState <= LU;
					
				elsif(STATUS_in = "00100") then
					nextState <= LC;
				
				elsif(STATUS_in = "00000") then
					nextState <= L;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				else 
					nextState <= Invalid;
			
				end if; 
		 --------------------------					
				when LU => 
				control_out <= "00000";
				
				if(STATUS_in = "01000") then 
					nextState <= LUR;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				elsif(STATUS_in = "00000") then
					nextState <= LU;
					
				else 
					nextState <= Invalid;
			
				end if; 
		 --TrainMode------------------------			
				when LUR => 
				control_out <= "11010";
				
				if(STATUS_in = "10000") then 
					nextState <= L;
					
				elsif(STATUS_in = "00100") then
					nextState <= C1;
					
				elsif(STATUS_in = "00000") then
					nextState <= LUR;	
					
				elsif (CLR = '1') then 
					nextState <= Off;
					
				else 
					nextState <= LUR;
			
				end if; 
		 --------------------------			
			when LC => 
				control_out <= "00000";
				
				if(STATUS_in = "10000")   then 
					nextState <= LCL;
					
				elsif(STATUS_in = "01000") then
					nextState <= LCR;
				
				elsif(STATUS_in = "00000") then
					nextState <= LC;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				else 
					nextState <= Invalid;
			
				end if; 
				
		--WallMode_FSM------------------------	
				when LCL => 
				control_out <= "11101";
				
				if(STATUS_in = "10000") then 
					nextState <= L;
					
				elsif(STATUS_in = "00100") then
					nextState <= C1;
					
				elsif(STATUS_in = "00000") then
					nextState <= LCL;
					
				elsif (CLR = '1') then 
					nextState <= Off;
					
				else 
					nextState <= LCL;
			
				end if; 
		 --------------------------			
			when C1 => 
				control_out <= "00000";
				
				if(STATUS_in = "00100") then 
					nextState <= C2;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
				
				elsif(STATUS_in = "00000") then
					nextState <= C1;
					
				else 
					nextState <= Invalid;
			
				end if; 
		 --------------------------		
			when C2 => 
				control_out <= "00000";
				
				if(STATUS_in = "00100") then 
					nextState <= C3;
					
				elsif(STATUS_in = "00000") then
					nextState <= C2;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				else 
					nextState <= Invalid;
			
				end if; 
		 --------------------------		
			when C3 => 
				control_out <= "00000";
				
				if(STATUS_in = "00100") then 
					nextState <= C4;
				
				elsif(STATUS_in = "00000") then
					nextState <= C3;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				else 
					nextState <= Invalid;
			
				end if; 
		 --------------------------		
			when C4 => 
				control_out <= "00000";
				
				if(STATUS_in = "00100") then 
					nextState <= C5;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				elsif(STATUS_in = "00000") then
					nextState <= C4;
					
				else 
					nextState <= Invalid;
			
				end if; 
				
		 --PhysicsMode------------------------		
			when C5 => 
				control_out <= "11100";
				
				if(STATUS_in = "10000") then 
					nextState <= L;
					
				elsif(STATUS_in = "00100") then 
					nextState <= C1;
				
				elsif(STATUS_in = "00000") then
					nextState <= C5;
					
				elsif (CLR = '1') then 
					nextState <= Off;
					
				else 
					nextState <= C5;
			
				end if; 
		 --------------------------		
			when LCR => 
				control_out <= "00000";
				
				if(STATUS_in = "00100") then 
					nextState <= LCRC;
					
				elsif(STATUS_in = "00000") then 
					nextState <= LCR;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				else 
					nextState <= Invalid;
			
				end if; 
				
		 --------------------------		
			when LCRC => 
				control_out <= "00000";
				
				if(STATUS_in = "10000") then 
					nextState <= LCRCL;
					
				elsif(STATUS_in = "00000") then 
					nextState <= LCRC;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				else 
					nextState <= Invalid;
			
				end if; 
				
		 --PingPongMode --------------------------		
			when LCRCL => 
				control_out <= "11011";
				
				if(STATUS_in = "10000") then 
					nextState <= L;
				
				elsif(STATUS_in = "00100") then 
					nextState <= C1;
					
				elsif(STATUS_in = "00000") then 
					nextState <= LCRCL;
					
				elsif(STATUS_in = "11001") then
					nextState <= OFF;
					
				elsif (CLR = '1') then 
					nextState <= Off;
					
				else 
					nextState <= LCRCL;
					
				end if; 
				end case; 
	end process; 		

end Behavioral;

