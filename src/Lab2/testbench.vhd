----library ieee;--
--use ieee.std_logic1164.all;
--use IEEE.NUMERIC_STD.ALL;
--use STD.textio.all;
--use ieee.std_logic_textio.all;
--
--
---- Declare the Component under test
--
--entity g04_MAC_tb is
--port ( x			: in std_logic_vector(7 downto 0); -- first input
--		 y			: in std_logic_vector(8 downto 0); -- second input
--		 N			: in std_logic_vector(9 downto 0); -- total number of inputs
--		 clk		: in std_logic; --clock
--		 rst 		: in std_logic; --asynchronous active - high reset
--		 mac		: out std_logic_vector(16 downto 0); -- output of MAC unit
--		 ready 	: out std_logic); -- denotes the validity of the mac signal
--end g04_MAC_tb;
--
---- Testbench internal signals
--file file_VECTORS_X : text;
--file file_VECTORS_X : text;
--file file_RESULTS : text;
--
--constant clk_peiod : time := 100 ns;
--
--signal x_in		: in std_logic_vector(?? downto 0); 
--signal y_in			: in std_logic_vector(?? downto 0); 
--signal N_in		: in std_logic_vector(9 downto 0); 
--signal clk_in		: in std_logic; 
--signal rst_in 		: in std_logic; 
--signal mac_in		: out std_logic_vector(?? downto 0); 
--signal ready_in 	: out std_logic);
--
--
--architecture test of g04_MAC_b is
--
--begin
--
---- instantiate MAC
--	g04_MAC_INST : g04_MAC;
--	port map (x => x_in;
--				 y => y_in;
--				 N => N_in;
--				 clk => clk_in;
--				 rst => rst_in;
--				 mac => mac_out;
--				 readyS => read_out);


--	clk_generation
    clk_generation : process 
    begin 
        clk <= '1'
        wait for clk_PERIOD / 2; 
        clk <= '0' 
        wait for clk_PERIOD / 2; 
     end process clk_generation;
      
      --Feeding Inputs
     feeding_instr : process is 
        variable v_lline1 : line;
        variable v_lline2 : line; 
        variable v_Oline  : line; 
        variable v_x_in   : in std_logic_vector(?? downto 0);
        variable v_y_in   : in std_logic_vector(?? downto 0);
    begin
      --rest the circuit
      N_in <= "1111101000";  --N = 1000
      rst <= '1';
      wait until rising_edge(clk);
      wait until rising_edge(clk);
      rst <= '0';

      file_open(file_VECTORS_X, "lab1-x-fixed-point.txt", read-mode);
      file_open(file_VECTORS_Y, "lab1-y-fixed-point.txt", read-mode);
      file_open(file_RESULTS, "lab1-out.txt", write-mode);

      while not endfile (file_VECTORS_X) loop
         readline(file_VECTORS_X, v_lline1);
         read(v_lline1, v_x_in);
         readline(file_VECTORS_Y, v_lline2);
         read(v_lline2, v_y_in);
      
         x_in <= v_x_in;
         y_in <= v_y_in;
    
         wait until rising_edgeclk);
       end loop;

       if ready_out = '1' then
         write(v_Oline, mac_out);
         writeline(file_RESULTS, v_Oline);
         wait;
      end if;
    end process;