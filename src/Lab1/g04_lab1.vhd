library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity g04_lab1 is
	Port( clk			: in std_logic;
			direction	: in std_logic;
			rst			: in std_logic;
			enable		: in std_logic;
			output		: out std_logic_vector(7 downto 0));
end g04_lab1;

Architecture bitCounter of g04_lab1 is
	signal count : unsigned(7 downto 0);
	begin
	counter1 : process(rst, clk)
		begin
			if rising_edge(clk) then
				if rst = '1' then
					count <= X"00";
				elsif enable = '1' then
					if direction = '1' then count <= count + 1;
					else count <= count - 1;
					end if;
				end if;
			end if;
		end process;
		output <= std_logic_vector(count);
end bitCounter;
	