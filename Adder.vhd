library IEEE;
use ieee.std_logic_1164.all;

Entity Adder is port(
	A   : In std_logic;
	B   : In std_logic;
	CI  : In std_logic;
	Sum : Out std_logic;
	CO  : Out std_logic 
	);
End Adder; 

Architecture behavioral of Adder Is

Begin

	sum <= A xor B xor CI ;
	CO <= (A and B) or (CI and A) or (CI and B) ;

end behavioral; 