library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Newton is
    port (
        clk   	    : in  std_logic;
		x_in		: in std_logic_vector(35 downto 0); --W=36 and F=18
		y_in		: in std_logic_vector(35 downto 0);
		y_out		: out std_logic_vector(35 downto 0)  
    );
end Newton;

architecture Newton_arch of Newton is

  signal guess_newton            : unsigned(35 downto 0);
  signal guess_total 	   : unsigned(143 downto 0);
  signal guess_squared         : unsigned(71 downto 0);
  signal guess_input          : unsigned(107 downto 0);
  signal guess_three        : unsigned(107 downto 0);
  signal guess_top       : unsigned(143 downto 0); 
  signal three         : unsigned(107 downto 0) := "000000000000000000000000000000000000000000000000000011000000000000000000000000000000000000000000000000000000";

begin

	
   --Squares the guess
    guess_squared <= unsigned(y_in) * unsigned(y_in);
	--Times by input
    guess_input <= unsigned(x_in) * guess_squared;
	--Minus Three as defined
    guess_three <= three - guess_input;
	--Times by guess 
    guess_top <= guess_three * unsigned(y_in);
	--Divide by two
    guess_total <= shift_right(guess_top, 1);
	--Grab middle 36 bits
    guess_newton <= guess_total(89 downto 54);
    y_out <= std_logic_vector(guess_newton);

end architecture;
