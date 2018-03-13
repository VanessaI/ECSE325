library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity g04_FIR is
port ( x			: in std_logic_vector(15 downto 0); --input signal
		 clk		: in std_logic;  -- clock
		 rst		: in std_logic;  -- asynchronous active-high reset
		 y 		: out std_logic_vector(16 downto 0));  -- output signal
end g04_FIR;