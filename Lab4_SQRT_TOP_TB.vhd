library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lab4_SQRT_TOP_TB is
end entity;

architecture Lab4_SQRT_TOP_TB_arch of Lab4_SQRT_TOP_TB is

	component Lab4_SQRT_TOP
		  port (
        	clk     : in  std_logic;
		x		: in std_logic_vector(35 downto 0); --W=36 and F=18
		y		: out std_logic_vector(35 downto 0));
	end component;
	
	--Signals
	signal clk_TB 		: std_logic;
	signal x_TB, y_TB 	: std_logic_vector(35 downto 0);
	
	constant CLK_PERIOD : time := 10 ns;
	
begin
	
	DUT1 : Lab4_SQRT_TOP port map(clk => clk_TB,
				      x		=> x_TB,
				      y		=> y_TB);
	
	--Stepping the CLOCK
Clk_process :process
    begin
        clk_TB <= '0';
        wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
        clk_TB <= '1';
        wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
   end process;

	x_TB <= "000000000000000000000100010000000011";
		
    --Stimulus Generation
	
end architecture;
			