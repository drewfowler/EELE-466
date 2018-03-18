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

	signal done	: std_logic;
	signal answer	: signed(35 downto 0);
	signal top	: signed(143 downto 0);
	signal count 	: integer;
	
	constant three	: signed(35 downto 0) := "000000000000000000000000000000000011";
	constant one	: signed(35 downto 0) := "000000000000000000000000000000000001";
	constant zero	: std_logic_vector(35 downto 0) := "000000000000000000000000000000000000";
	constant stop	: integer := 10;

begin

	STATE_MEMORY : process(clk)
		begin	
			current_state <= next_state;
	end process;
	
	NEXT_STATE_LOGIC : process(current_state)
		begin
			case(current_state) is
				when iteration =>	if (count = stop) then
										next_state <= finish;
										--count <= 0;
									else
										next_state <= calculate;
									end if;
									
				when calculate =>   next_state <= iteration;
				
				when finish => 		if(done = '0') then
										next_state <= iteration;
									else
										next_state <= finish;
									end if;
				when others =>		next_state <= iteration;
			end case;
	end process;
	
	OUTPUT_LOGIC : process(current_state)
		begin
			case(current_state) is
				when iteration => count <= count + 1;
						
				when calculate => --equation
								count <= 0;
								 -- top <= answer * (three - (x_in*(answer*answer)));
 								answer <= answer * (three - (signed(x_in) *(answer*answer)));
								answer <= SHIFT_RIGHT(answer, 1);
								--answer <= top(35 downto 0);
				
				when finish => y_out <= std_logic_vector(answer);

				when others => y_out <= zero;
			end case;
	end process;
			


end architecture;

