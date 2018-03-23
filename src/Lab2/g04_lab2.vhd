library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity g04_lab2 is
port ( 
		x		: in std_logic_vector(7 downto 0); -- first input
		y		: in std_logic_vector(8 downto 0); -- second input
		N		: in std_logic_vector(9 downto 0); -- total number of inputs
		clk		: in std_logic; --clock
		rst 	: in std_logic; --asynchronous active - high reset
		mac		: out std_logic_vector(16 downto 0); -- output of MAC unit
		ready 	: out std_logic); -- denotes the validity of the mac signal
end g04_lab2;

architecture mac_Implementation of g04_lab2 is 
	signal temp : signed(16 downto 0);
	begin
	counter : process(rst, clk)
		begin
		if rst = '1' then
			-- do nothing
		elsif rising_edge(clk) then
			temp <= (others => '0');
			ready <= '0';		
				for i in 1 to 1000 loop				-- N = 1000
					temp <= temp + signed(x) * signed(y);
				end loop;
				ready <= '1';
		end if;	
	end process;
	mac <= std_logic_vector(temp);
end mac_Implementation;