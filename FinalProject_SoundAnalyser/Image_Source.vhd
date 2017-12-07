----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2017 03:45:09 PM
-- Design Name: 
-- Module Name: Image_Source - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Image_Source is
  port(
        CLK           : in std_logic;
        --activate      : in std_logic;
       row, column   : in std_logic_vector(9 downto 0);
       R_en, G_en, B_en : in std_logic;
       R, G, B       : out std_logic_vector(3 downto 0) := (others => '0'));
end entity;

architecture behavioural of Image_Source is


begin
 
  RGB : process(CLK,R_en, B_en, G_en)
  begin
    if (CLK'EVENT AND CLK='1') then
              if (R_en = '1' ) then 
                    if  ( row < "0111100000"  and column > "0000000000" and column < "0011010101")  then -- row : 480 ; column : 0 - 213
                      R <= (others => '1');
                      G <= (others => '0');
                      B <= (others => '0');
                    else
                      R <= (others => '0');
                    end if;
                 
              end if; 
             if (G_en = '1' ) then
                    if  (row < "0111100000" and column > "0011011000" and column < "0110101010")  then -- row : 480 ;column : 216 - 426
                       G <= (others => '1');
                       R <= (others => '0');
                       B <= (others => '0');
                    else
                       G <= (others => '0');
                    end if;
              end if;      
              
              
             if  (B_en = '1') then   
                    if  (row < "0111100000" and column > "110101100" and column < "1010000000")  then -- row : 480 ; column : 428 - 640
                      B <= (others => '1');
                      G <= (others => '0');
                      R <= (others => '0');
                    else
                      B <= (others => '0');
                    end if;
                
              end if;
     end if;         
end process;

end behavioural;