library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;


entity g04_FIR_tb is
end g04_FIR_tb;

architecture test of g04_FIR_tb is

	--Declare component

	component g04_FIR is 
		port ( 	
			x		: in std_logic_vector(15 downto 0); --input signal
			--coef		: in std_logic_vector(15 downto 0); --input of coefficients
			clk		: in std_logic;  -- clock
			rst		: in std_logic;  -- asynchronous active-high reset
			y 		: out std_logic_vector(16 downto 0) -- output signal
		);
	end component g04_FIR;

	-- Testbench internal signals
	file file_IN 		: text;
	--file file_COEF	: text;
	file file_RESULTS 	: text;
	
	constant clk_PERIOD : time := 100 ns;
	
	signal x_in			: std_logic_vector(15 downto 0);
	--signal coef_in	: std_logic_vector(15 downto 0);
	signal clk_in		: std_logic;
	signal rst_in		: std_logic;
	signal y_out		: std_logic_vector(16 downto 0);


begin
	-- instantiate FIR
		g04_FIR_INST : g04_FIR
		port map (
			x 		=> x_in,
			--coef 	=> coef_in,
			clk 	=> clk_in,
			rst 	=> rst_in,
			y 		=> y_out
		);
	
	-- Clock Generation
	clk_generation : process 
		 begin 
			  clk_in <= '1';
			  wait for clk_PERIOD / 2; 
			  clk_in <= '0';
			  wait for clk_PERIOD / 2; 
	end process clk_generation;
				
			
	--Feeding Inputs
	feeding_instr : process is 
		variable v_lline1 : line;
		variable v_lline2 : line; 
		variable v_Oline  : line; 
		variable v_x_in   : std_logic_vector(15 downto 0);
		--variable v_coef_in   : std_logic_vector(15 downto 0);
	 
	begin
		--reset the circuit
		rst_in <= '1';
		wait until rising_edge(clk_in);
		wait until rising_edge(clk_in);
		rst_in <= '0';

		file_open(file_IN, "C:\ecse 325 LABS\src\Lab3\lab3-in-converted.txt", read_mode);
		--file_open(file_COEF, "C:\ecse 325 LABS\src\Lab3\lab3-coef-converted.txt", read_mode);
		file_open(file_RESULTS, "C:\ecse 325 LABS\src\Lab3\lab3-output.txt", write_mode);

--		while not endfile (file_COEF) loop
--			-- read all the coefficients from the file
--			readline(file_COEF, v_lline2);	-- make sure input file has values on individual lines
--			read(v_lline2, v_coef_in);
--			
--			coef_in <= v_coef_in;
--			
--			wait until rising_edge(clk_in);
--		end loop;
		
		while not endfile (file_IN) loop
			-- read all the input values from the file
			readline(file_IN, v_lline1);		-- make sure input file has values on individual lines
			read(v_lline1, v_x_in);
			
			x_in <= v_x_in;

			write(v_Oline, y_out);
			writeline(file_RESULTS, v_Oline);
	 
			wait until rising_edge(clk_in);
		 end loop;
		 wait until rising_edge(clk_in);
		 wait until rising_edge(clk_in);
	 	 wait;
	end process feeding_instr;
end test;