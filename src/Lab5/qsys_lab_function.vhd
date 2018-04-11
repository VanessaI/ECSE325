LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY qsys_lab_function IS
PORT ( clock, resetn : IN STD_LOGIC;
	read, write, chipselect : IN STD_LOGIC;
	address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	in_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	out_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
);
END qsys_lab_function ;

ARCHITECTURE Behavior OF qsys_lab_function IS
SIGNAL  input1, input2: std_logic_vector(31 DOWNTO 0); 
signal routput: unsigned(31 downto 0);

BEGIN
   process(clock,resetn)
	begin
	if(resetn='0') then 
			input1<= (others=>'0');
			input2<= (others=>'0');
			routput<=(others=>'0');
	elsif(rising_edge(clock)) then
		
		 if (write = '1') then
	
			if (address(0) = '1') then 
				input1 <= in_data;
			elsif(address(0)='0') then 
				input2<=in_data;
		end if;
	
		elsif(read='1') then
			routput<=unsigned(input1(15 downto 0))*unsigned(input2(15 downto 0));
		
		end if;
		
	end if;
	end process;
	out_data<= std_logic_vector(routput);

END Behavior;
