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

	type State_Type is (iteration,calculate,finish);
	signal current_state, next_state : State_Type;

	signal top	: signed(143 downto 0);
	
	signal top0		: signed(71 downto 0);
	signal top1		: signed(143 downto 0);
	
	constant three	: signed(35 downto 0) := "000000000000000000000000000000000011";
	constant one	: signed(35 downto 0) := "000000000000000000000000000000000001";
	constant zero	: std_logic_vector(35 downto 0) := "000000000000000000000000000000000000";
	constant stop	: integer := 10;

begin

	
	TOP_PART : process(clk)
		begin
			top0 <= signed(y_in) * three;
			top1 <= signed(y_in)* (signed(x_in) * ( signed(y_in) * signed(y_in) ));
	end process;
	
	BOTTOM_PART	: process(clk)
		begin
			top <= SHIFT_RIGHT((top0 - top1),1);
	end process;
									
	y_out <= std_logic_vector(top(89 downto 54));

end architecture;
