library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator is
    generic(
        WIDTH : integer := 3
    );
    Port ( 
	clk : in STD_LOGIC;
           CompA : in STD_LOGIC_VECTOR (WIDTH   downto 0);
           CompB : in STD_LOGIC_VECTOR (WIDTH   downto 0);
           Eq: out STD_LOGIC);
end comparator;

architecture Behavioral of comparator is    
begin
    process(clk) begin
    	if (CompA = CompB) then
        	Eq <= '1';   
    	else 
          	Eq <= '0';
    	end if;
    end process;        
end Behavioral;
