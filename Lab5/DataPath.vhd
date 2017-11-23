-- Entity:         DataPath
-- Written By:     Morayo Ogunsina
-- Date Created:   11/9/2015
-- Description:    Data Path of the the FSMs
--                 when it hits it .Button Sequence LEFT-CENTER-LEFT 
--                 enters this mode,Displays "D".
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


entity DataPath is
    port  (CLK      			: in  STD_LOGIC;
		     CLR      			: in  STD_LOGIC;
		     STROBE   			: in  STD_LOGIC;
		     CONTROL_out     : in  STD_LOGIC_VECTOR(4  downto 0);
	        TrainMode_FSM   : in  STD_LOGIC_VECTOR(15 downto 0);
	        PingPongMode 	: in  STD_LOGIC_VECTOR(15 downto 0);
	        PhysicsMode 		: in  STD_LOGIC_VECTOR(15 downto 0);
	        WallMode_FSM 	: in  STD_LOGIC_VECTOR(15 downto 0);
	        SEGMENT  			: out STD_LOGIC_VECTOR(0 to 6); 
	        ANODE    			: out STD_LOGIC_VECTOR(7 downto 0);
	        LED      			: out STD_LOGIC_VECTOR(15 downto 0));
	
end DataPath;

architecture Behavioral of DataPath is

    
    signal Q_int     : STD_LOGIC_VECTOR(3 downto 0);    -- register signals   
    signal Hex2_int  : STD_LOGIC_VECTOR(31 downto 0);   -- word signals 

begin

  -- prep the word to put in register before data enters wordTo8dig7seg
	Hex2_int (31 downto 4)  <= (others => '0');
	Hex2_int (3 downto 0)   <= Q_int(3 downto 0); 
	
	
	
	HEX: WordTo8dig7seg
	port map(STROBE  	=> STROBE, 
				CLK     	=> CLK,
				CLR     	=> CLR,
				WORD    	=> Hex2_int,
				DIGIT_EN => "00000001",
				ANODE    => ANODE,
				SEGMENT  => SEGMENT);
				
	Reg: Register_nbit
	generic map (4)
	port map    (D    => CONTROL_out(3 downto 0),
				    LOAD => CONTROL_out(4), 
				    CLK  => CLK,
				    CLR  => CLR,
				    Q    => Q_int);
					 
	   --MUX 5:1 led based off last 3 bits of control out  
	LED <= TrainMode_FSM  when Q_int(2 downto 0) = "010" else
			 PingPongMode   when Q_int(2 downto 0) = "011" else 
			 PhysicsMode    when Q_int(2 downto 0) = "100" else 
			 WallMode_FSM   when Q_int(2 downto 0) = "101" else 
		    "0000000000000000"; 
end Behavioral;

