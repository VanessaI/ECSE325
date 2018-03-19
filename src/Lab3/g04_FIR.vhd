library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity g04_FIR is
port ( x			: in std_logic_vector(15 downto 0); --input signal
		 coef		: in std_logic_vector(15 downto 0);  --coefficient input
		 clk		: in std_logic;  -- clock
		 rst		: in std_logic;  -- asynchronous active-high reset
		 y 		: out std_logic_vector(16 downto 0));  -- output signal
end g04_FIR;

architecture fir_implementation of g04_FIR is


	-- input values x(n) are stored in "lab3-in-converted.txt", (W,F) = (16,15)
	-- weights b_i are stored in "lab3-coef-converted.txt", (W,F) = (16,15)
	-- output values y(n) should have (W,F) = (17,15)

	-- have an array of registers to store input values as they move along
	-- have an array that stores all 25 values b_i
	-- take input values in one at a time, one per clock cycle, bumping one off the end of the list each time
	-- on each clock cycle, perform the calculation for y(n) using the formula on slide 4 and the 25 input values and the 25 values of b_i
	
	type ARRAY25 is array(24 downto 0) of std_logic_vector(15 downto 0);
	signal COEFF_ARRAY : ARRAY25;
	signal INPUT_ARRAY : ARRAY25;
	signal i 	: integer := 0;
	signal total : std_logic_vector(16 downto 0);
	
	begin
		counter : process(rst, clk)
			begin
			
			if (rising_edge(clk) and i < 25) then
				COEFF_ARRAY(i) <= coef;
				INPUT_ARRAY(25-i) <= x;
			end if;
			
			if(rising_edge(clk) and i >= 25) then
				if rst = '1' then
					-- what to do
					
				else 
					-- multiply all 25 input values by all 25 coefficients, then output that to y
					total <= "0000000000000000";
					for t in 0 to 24 loop
						total <= std_logic_vector(signed(total) + (signed(INPUT_ARRAY(t)) * signed(COEFF_ARRAY(t))));
					end loop;
					y <= total;
					
					-- shuffle input values along the array
					for t in 24 to 1 loop
						INPUT_ARRAY(t) <= INPUT_ARRAY(t-1);
					end loop;
					INPUT_ARRAY(0) <= x;
				end if;
			end if;
		end process; 

end fir_implementation;
