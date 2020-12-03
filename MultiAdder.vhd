library IEEE;
use ieee.std_logic_1164.all;

entity MultiAdder is
    	port (	
		A    : In  std_logic_vector(2 downto 0);
		B    : In  std_logic_vector(2 downto 0);
		Sum  : Out std_logic_vector(3 downto 0)	 	
	);
end MultiAdder;
 
Architecture structural of MultiAdder is

component Adder
	port(
		A  : In std_logic;
		B  : In std_logic;
		CI : In std_logic;

		Sum: Out std_logic;
		CO : Out std_logic);
end component;

	signal Carryout: std_logic_vector(1 downto 0);

Begin

	Adder0: Adder port map(A=>A(0), B=>B(0) , CI=>'0' 	  , Sum=>Sum(0) , CO=>Carryout(0) );
	Adder1: Adder port map(A=>A(1), B=>B(1) , CI=>Carryout(0) , Sum=>Sum(1) , CO=>Carryout(1) );
	Adder2: Adder port map(A=>A(2), B=>B(2) , CI=>Carryout(1) , Sum=>Sum(2) , CO=>Sum(3) 	  );
	

end structural; 
