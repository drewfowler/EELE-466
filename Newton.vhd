library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Newton is
    port (
        clk   	    : in  std_logic;
		x_in		: in std_logic_vector(35 downto 0); --W=36 and F=18
		y_in		: in std_logic_vector(35 downto 0);
		y_out		: out std_logic_vector(35 downto 0)  
    );
end Newton;

architecture Newton_arch of Newton is

begin


end architecture;

