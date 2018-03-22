library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity g04_FIR is
port ( 	
		x			   : in std_logic_vector(15 downto 0); --input signal
		clk			   : in std_logic;  -- clock
		rst			   : in std_logic;  -- asynchronous active-high reset
		y 			   : out std_logic_vector(16 downto 0));  -- output signal
end g04_FIR;

architecture fir_implementation of g04_FIR is
	-- type ARRAY32 is array(24 downto 0) of signed(31 downto 0);
	type ARRAY16 is array(24 downto 0) of signed(15 downto 0);		-- define an array type
	signal COEFF_ARRAY : ARRAY16;						-- create array to hold coefficients
	signal INPUT_ARRAY : ARRAY16;						-- create array to hold input values	
	signal TEMP_TOTAL  : signed(31 downto 0);

	begin
		-- fill input array with initial values of 0
		INPUT_ARRAY <= (others=>(others=>'0'));

		COEFF_ARRAY(0) <= "0000001001110010";
		COEFF_ARRAY(1) <= "0000000000010001";
		COEFF_ARRAY(2) <= "1111111111010011";
		COEFF_ARRAY(3) <= "1111111011011110";
		COEFF_ARRAY(4) <= "0000001100011001";
		COEFF_ARRAY(5) <= "1111110110100111";
		COEFF_ARRAY(6) <= "1111110000001110";
		COEFF_ARRAY(7) <= "0000110110111100";
		COEFF_ARRAY(8) <= "1110110001110011";
		COEFF_ARRAY(9) <= "0000110111110111";
		COEFF_ARRAY(10) <= "0000001100000111";
		COEFF_ARRAY(11) <= "1110101000001010";
		COEFF_ARRAY(12) <= "0001111000110011";
		COEFF_ARRAY(13) <= "1110101000001010";
		COEFF_ARRAY(14) <= "0000001100000111";
		COEFF_ARRAY(15) <= "0000110111110111";
		COEFF_ARRAY(16) <= "1110110001110011";
		COEFF_ARRAY(17) <= "0000110110111100";
		COEFF_ARRAY(18) <= "1111110000001110";
		COEFF_ARRAY(19) <= "1111110110100111";
		COEFF_ARRAY(20) <= "0000001100011001";
		COEFF_ARRAY(21) <= "1111111011011110";
		COEFF_ARRAY(22) <= "1111111111010011";
		COEFF_ARRAY(23) <= "0000000000010001";
		COEFF_ARRAY(24) <= "0000001001110010";
		
		filter : process(rst, clk)
		begin
			if rst = '1' then
				-- reset array values to 0
				INPUT_ARRAY <= (others=>(others=>'0'));
			elsif(rising_edge(clk)) then
				-- reset temporary array
				TEMP_TOTAL <= "00000000000000000000000000000000";

				-- shuffle values along input array
				for i in 1 to 24 loop
					INPUT_ARRAY(25 - i) <= INPUT_ARRAY(25 - (i+1)); 
				end loop;
				INPUT_ARRAY(0) <= signed(x);

				-- calculate output value
				for i in 1 to 24 loop
					TEMP_TOTAL <= TEMP_TOTAL + COEFF_ARRAY(25 - i)*INPUT_ARRAY(25 - i);
				end loop;
			end if;
		end process filter;
	-- assign result to output outside of the process block, truncating unused digits
	y <= std_logic_vector(TEMP_TOTAL(31 downto 15));
end fir_implementation;