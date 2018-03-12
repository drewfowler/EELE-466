library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Y0 is
    port (
        	clk   	    : in  std_logic;
		x_in		: in std_logic_vector(35 downto 0); --W=36 and F=18
		y_out		: out std_logic_vector(35 downto 0)  
   	 );
end Y0;

architecture Y0_arch of Y0 is

	signal Z		: std_logic_vector(5 downto 0); --lzc_count
	signal beta		: signed(5 downto 0); --Beta
	signal alpha	: signed(11 downto 0); --Alpha
	signal check	: std_logic; --1 if beta is even, 0 if beta is odd
	signal plus		: std_logic; --1 is negative, 0 is positive
	signal Xa		: signed(35 downto 0);
	signal Xb		: signed(35 downto 0);
	signal Xb_look	: STD_LOGIC_VECTOR (11 DOWNTO 0);
	signal address_sig	: STD_LOGIC_VECTOR (5 DOWNTO 0);
	signal y_out_sig	: signed(35 downto 0);
	
	signal beta0	: signed(11 downto 0);
	signal beta1	: signed(5 downto 0);
	---signal test0	: signed(11 downto 0);
	
	constant a	: signed(35 downto 0) := "000000000000000000101101001111111000";
	constant half	: signed(35 downto 0) := "000000000000000000100000000000000000";
	constant negtwo	: signed(5 downto 0)  := "111110";
	


	component lzc
		port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (35 downto 0);
        lzc_count  : out std_logic_vector ( 5 downto 0));
	end component;
	
	component ROM_inst
		port
		(
			address		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
	end component;
	

begin

	Z0 : lzc PORT MAP (
		clk 	=> clk,
		lzc_vector 	=> x_in,
		lzc_count	=> Z
	);
	
	ROM_inst_0 : ROM_inst PORT MAP (
		address	 => address_sig,
		clock	 => clk,
		q	 => Xb_look
	);
	
	CALC_GUESS : process (clk)
	
		--variable beta0,beta1	: signed(35 downto 0);
		--variable beta1	: signed(35 downto 0);
		--variable beta0  : signed(11 downto 0);
	
	begin
		--Calc Beta
		beta <= 17 - signed(Z);
		
		--Checking if Beta is even or odd
		if(beta(0) = '1') then
			check <= '0'; --Odd
		else 
			check <= '1'; --Even
		end if;

		--Checks if beta is positive or negative
		if(beta(5) = '1') then
			plus <= '1'; --negative
		else
			plus <= '0'; --positive
		end if;
		
		--beta <= to_signed(15,6);
		
		--beta0 <= "000000000000000000000000000000" & shift_right(beta, 1);-- -2*beta
		
		--beta <= SHIFT_LEFT(beta,1);-- -2*beta
		
		--beta0 <= (beta * negtwo);
		--Calc Alpha
		--We need to check which way to shift according to if beta is positive or negative
		if(plus = '1') then --negative
			beta0 <= (beta * negtwo);-- -2*beta
			beta1 <= SHIFT_RIGHT(beta, 1);-- 0.5*beta
		else			--positive
			beta0 <= (beta * negtwo);-- -2*beta
			beta1 <= SHIFT_RIGHT(beta, 1);-- 0.5*beta
		end if;
		
		
		--Alpha calc if even or odd
		if(check = '1') then --Even
			alpha <= beta0 + beta1; ---2 * beta + 0.5 * beta
		--else			--Odd
			--alpha <= beta0 + beta1 + half;
		end if;
		
		--Calc Xa
			--What if alpha has decimals
			--Round to nearest int?
			Xa <= SHIFT_LEFT(signed(x_in), to_integer(alpha));
		--Calc Xb
			Xb <= SHIFT_LEFT(signed(x_in), to_integer(-beta));
		
		
		-- --Calc Lookup
--		address_sig <= "001000";
		address_sig <= std_logic_vector(Xb(15 downto 10));
		
		
		-- --Calc Guess
		if(check = '1') then--Even
			y_out_sig <= Xa * signed(Xb_look);
		else			--Odd
			y_out_sig <= Xa * Xb * a;
		end if;
		
		-- Answer
		y_out <= std_logic_vector(y_out_sig);

	end process;

end architecture;
