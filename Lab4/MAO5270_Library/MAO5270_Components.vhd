----------------------------------------------------------------------------
-- Entity:        MAO5270_Components
-- Written By:    Morayo Ogunsina
-- Date Created:  26 Oct 15
-- Description:   Package definition for common components
--
-- Revision History (date, initials, description):
-- 	(none)
-- Dependencies:
--  All components declared in this definition
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



----------------------------------------------------------------------------
package MAO5270_Components is

	component FullAdder is
		port (A     : in  STD_LOGIC;
				B     : in  STD_LOGIC;
				C_in  : in  STD_LOGIC;
				C_out : out STD_LOGIC;
				SUM   : out STD_LOGIC);
	end component;


    -- declare the  InvertOrPass component
   component InvertOrPass is
	Port   ( B         : in  STD_LOGIC_VECTOR (3 downto 0);
            BXOR      : out STD_LOGIC_VECTOR (3 downto 0);
            SUBTRACT  : in  STD_LOGIC);
  end component;

   -- declare the  OverflowDetect component
	component OverflowDetect is 
	    Port ( A_MSB     : in  STD_LOGIC;
              B_MSB     : in  STD_LOGIC;
              SUM_MSB   : in  STD_LOGIC;
              SUBTRACT  : in  STD_LOGIC;
              OVERFLOW  : out STD_LOGIC);
  end component;
	component RippleCarryAdder_4bit is
	generic(n : integer := 4);
		port (A     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				B     : in  STD_LOGIC_VECTOR (n-1 downto 0);
				C_in  : in  STD_LOGIC;
				C_out : out STD_LOGIC;
				SUM   : out STD_LOGIC_VECTOR (n-1 downto 0));
	end component;
	
	-- declare the Mus4to1_4bit
	component Mux4to1 is
	generic(n : integer );
    Port ( X0  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X1  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X2  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X3  : in  STD_LOGIC_VECTOR (n-1 downto 0);
			  X4  : in  STD_LOGIC_VECTOR (n-1 downto 0);
			  X5  : in  STD_LOGIC_VECTOR (n-1 downto 0);
			  X6  : in  STD_LOGIC_VECTOR (n-1 downto 0);
			  X7  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           SEL : in  STD_LOGIC_VECTOR (2 downto 0);
           Y   : out STD_LOGIC_VECTOR (n-1 downto 0));
     
  end component;
  
   -- declare the ButtonEncoder
  component ButtonEncoder is
    Port ( BTNL : in  STD_LOGIC;
           BTNR : in  STD_LOGIC;
           BTNU : in  STD_LOGIC;
			  BTND : in  STD_LOGIC;
			  BTNC : in  STD_LOGIC;
           SEL  : out STD_LOGIC_VECTOR (2 downto 0));
  end component;
  
    -- declare the AdderSubtractor_4bit
  component AdderSubtracator is
  generic(n : integer := 4);
    Port ( A        : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B        : in  STD_LOGIC_VECTOR (n-1 downto 0);
           SUBTRACT : in  STD_LOGIC;
           SUM      : out STD_LOGIC_VECTOR (n-1 downto 0);
           OVERFLOW : out STD_LOGIC);
   end component;
	
	-- declare the HexToSevenSeg
	 component HexToSevenSeg is
   Port  ( HEX    : in  STD_LOGIC_VECTOR (3 downto 0);
          SEGMENT : out  STD_LOGIC_VECTOR (0 to 6));
  end component;
  
     -- declare the Decoder3to8
   component Decoder3to8 is
     Port ( X    : in  STD_LOGIC_VECTOR (2 downto 0);
            EN   : in  STD_LOGIC_VECTOR (7 downto 0);
            YD   : out STD_LOGIC_VECTOR (7 downto 0));
   end component;
	
     -- declare the Counter_nbit
	 component Counter_nbit is
      generic (n : integer := 4);
		port (EN    :  in STD_LOGIC;
		      CLK   :  in STD_LOGIC;
				CLR   :  in STD_LOGIC;
				 Q    :  out STD_LOGIC_VECTOR(n-1 downto 0):= (OTHERS => '0'));
    end component;
   
    -- declare the CounterUpDown_nbit
	component CounterUpDown_nbit is
      generic (n : integer := 4);
		port (EN    :  in STD_LOGIC;
		      UP    :  in STD_LOGIC;
		      DOWN  :  in STD_LOGIC;
		      CLK   :  in STD_LOGIC;
				CLR   :  in STD_LOGIC;
				 Q    :  out STD_LOGIC_VECTOR(n-1 downto 0):= (OTHERS => '0'));
  end component;
  
	  -- declare the OneShot
	component OneShot is
  port (D    : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
		  Q    : out STD_LOGIC);
  end component ;
    
	 -- declare the Debouncer
	component Debouncer is
     port (D      : in STD_LOGIC;
	        SAMPLE : in STD_LOGIC;
			  CLK    : in STD_LOGIC;
			  Q      : out STD_LOGIC);
   end component;
	
	-- declare the DFFCLK_ENABLE 
	component Dff_CE is
    Port ( D   : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
			  Q   : out STD_LOGIC);
   end component;

    -- declare the Register_nbit 
   component Register_nbit is
      generic(n : integer := 8);   -- NUMBER OF STAGES
		Port (D      :    in   STD_LOGIC_VECTOR (n-1 downto 0);
		      LOAD   :    in   STD_LOGIC;
		      CLK    :    in   STD_LOGIC;
				CLR    :    in   STD_LOGIC;
				Q      :    out  STD_LOGIC_VECTOR(n-1 downto 0) := (OTHERS => '0'));
    end component;
  component PulseGenerator is
   generic (n        : integer := 4;
	         maxCount : integer := 15);
   port    (EN       : in  STD_LOGIC;
	         CLK      : in  STD_LOGIC;
            CLR      : in  STD_LOGIC;
            PULSE    : out STD_LOGIC);	
  end component;
   
 end MAO5270_Components;
----------------------------------------------------------------------------



----------------------------------------------------------------------------
package body MAO5270_Components is

end MAO5270_Components;
----------------------------------------------------------------------------
