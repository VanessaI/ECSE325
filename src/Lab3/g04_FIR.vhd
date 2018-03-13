library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity g04_FIR is
port ( 	x			: in std_logic_vector(15 downto 0); --input signal
		clk			: in std_logic;  -- clock
		rst			: in std_logic;  -- asynchronous active-high reset
		y 			: out std_logic_vector(16 downto 0));  -- output signal
end g04_FIR;

architecture fir_implementation of g04_FIR is
	-- input values x(n) are stored in "lab3-in-converted.txt", (W,F) = (16,15)
	-- weights b_i are stored in "lab3-coef-converted.txt", (W,F) = (16,15)
	-- output values y(n) should have (W,F) = (17,15)

	-- have an array of registers to store input values as they move along
	-- have an array that stores all 25 values b_i
	-- take input values in one at a time, one per clock cycle, bumping one off the end of the list each time
	-- on each clock cycle, perform the calculation for y(n) using the formula on slide 4 and the 25 input values and the 25 values of b_i
end fir_implementation;