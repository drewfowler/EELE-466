library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Lab4_SQRT_TOP is
    port (
        	clk     : in  std_logic;
		x		: in std_logic_vector(35 downto 0); --W=36 and F=18
		y		: out std_logic_vector(35 downto 0)
    );
end Lab4_SQRT_TOP;

architecture Lab4_SQRT_TOP_arch of Lab4_SQRT_TOP is

	signal guess : std_logic_vector(35 downto 0); --Guess Output
	
	
	component Y0
		port(clk   	    : in  std_logic;
			x_in		: in std_logic_vector(35 downto 0); --W=36 and F=18
			y_out		: out std_logic_vector(35 downto 0));
	end component;
	
	component Newton
		port(clk   	    : in  std_logic;
			x_in		: in std_logic_vector(35 downto 0); --W=36 and F=18
			y_in		: in std_logic_vector(35 downto 0);
			y_out		: out std_logic_vector(35 downto 0));
	end component;

begin

	
	G0 : Y0 PORT MAP (
		clk 	=> clk,
		x_in 		=> x,
		y_out		=> guess
	);
	
	N0 : Newton PORT MAP (
		clk 	=> clk,
		x_in		=> x,
		y_in 		=> guess,
		y_out		=> y
	);
		




end architecture;