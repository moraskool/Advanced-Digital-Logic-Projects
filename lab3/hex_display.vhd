--- This is a driver for a 7 segment LED display. It converts a 4-bit nybble
--- into a hexadecimal character 0-9a-f. Some letters are upper case others are
--- lower case in an effort to distinguish them from numbers so b and 6 differ
--- by the presence of the top segment being lit or not. (for example)
---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hex_display is
    Port ( 
		
		value : in std_logic_vector(3 downto 0);
		decimalpoint : in std_logic := '0';
		SW : in std_logic_vector(2 downto 0);
	   --CLK100MHZ : in std_logic;
	    blank : in std_logic;
	    test : in std_logic;
		channels : out std_logic_vector(7 downto 0);
	    segs : out std_logic_vector(6 downto 0));
end hex_display;

-- This is a good third project since it is simply combinatorial logic. When
-- synthesized the selection statement (case) generates a decoder that takes
-- four input lines and generates eight output lines. (the decimal point is 
-- always set to 'off.' If you want to get decimal point control, try adding
-- another pin (dp) to the port description, and then you can assign it with
-- a concurrent signal assignment 
architecture behavioral of hex_display is
    
    
    signal counting: std_logic_vector(3 downto 0);
begin

	
--	process(CLK100MHZ)
--   begin
     
--      if(rising_edge(CLK100MHZ)) then
--            if counting="1111" then
--               counting <="0000";
--            else
--               counting <= counting + 1;
--            end if;
--         end if;
      
--   end process;
	
	process (SW)
	begin
	
		case SW is
		
				when "000" => channels <= not X"01"; -- invert 1
				when "001" => channels <= not X"02"; -- invert 2
				when "010" => channels <= not X"04"; -- invert4
				when "011" => channels <= not X"08"; --invert 8
				when "100" => channels <= not X"10"; --invert 16
				when "101" => channels <= not X"20"; --invert 32
				when "110" => channels <= not X"40"; --invert 64
				when "111" => channels <= not X"80"; --invert 128
				
				when others => channels <=  X"00"; -- 0
		end case;
	
	
	end process;
	
	
  --  process (counting, CLK100MHZk,value, blank, test) is
    process (value, blank, test) is
    begin
	if (blank = '1') then
	    segs <= NOT "0000000";
	elsif (test = '1') then
	    segs <= NOT "1111111";
	else 
	
	    case value is
	 --   case counting is
		when "0000" => segs <= NOT "0111111"; -- 0
		when "0001" => segs <=NOT "0000110"; -- 1
		when "0010" => segs <=NOT "1011011"; -- 2
		when "0011" => segs <=NOT "1001111"; -- 3
		when "0100" => segs <=NOT "1100110"; -- 4
		when "0101" => segs <=NOT "1101101"; -- 5
		when "0110" => segs <=NOT "1111101"; -- 6
		when "0111" => segs <=NOT "0000111"; -- 7
		when "1000" => segs <=NOT "1111111"; -- 8
		when "1001" => segs <=NOT "1100111"; -- 9
		when "1010" => segs <=NOT "1110111"; -- A
		when "1011" => segs <=NOT "1111100"; -- b
		when "1100" => segs <=NOT "0111001"; -- c
		when "1101" => segs <=NOT "1011110"; -- d
		when "1110" => segs <=NOT "1111001"; -- E
		when others => segs <=NOT "1110001"; -- F
	    end case;
	end if;
    end process;
end behavioral;