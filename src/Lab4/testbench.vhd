library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity g04_FIR_tb is
end g04_FIR_tb;

architecture test of g04_FIR_tb is

	--Declare component

	component g04_FIR is 
		port ( 	
			x		: in std_logic_vector(15 downto 0); --input signal
			clk		: in std_logic;  -- clock
			rst		: in std_logic;  -- asynchronous active-high reset
			y 		: out std_logic_vector(16 downto 0) -- output signal
		);
	end component g04_FIR_tb;

	-- Testbench internal signals
	file file_IN 	    : text;
	file file_RESULTS	: text;
	
	constant clk_peiod  : time := 100 ns;
	
	signal x_in			: std_logic_vector(15 downto 0);
	signal clk_in		: std_logic;
	signal rst_in		: std_logic;
	signal y_out		: std_logic_vector(16 downto 0);


begin
	-- instantiate MAC
	g04_FIR_INST : g04_FIR_tb
	port map (
		x => x_in,
		clk => clk_in,
		rst => rst_in,
		y => y_out
	);
	

		
		
end process; 