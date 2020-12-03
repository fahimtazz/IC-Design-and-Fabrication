----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Chris Samson
-- 
-- Create Date: 11/02/2020 07:47:17 PM
-- Design Name: Linear Feedback Shift Register
-- Module Name: lfsr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Implements a linear feedback shift register to 
-- generate pseudo random output
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
    generic(
        width : natural := 3 -- 
    );
    Port ( clk : in std_logic;
           en : in std_logic;
           rst : in std_logic;
	   roll : in std_logic;
           seed : in std_logic_vector (width -1 downto 0);
           count : out std_logic_vector (width -1 downto 0));
end Counter;

architecture Behavioral of Counter is
    signal feedback : std_logic;
    signal count_int : std_logic_vector (width-1 downto 0);
    
begin
    feedback <= not(count_int(width-1) xor count_int(width - 2) ) ;
    
    process(clk, rst)
    begin
        if(rst = '1') then
            count_int <= seed;
        elsif (rising_edge(clk)) and (roll = '1')then
		if(en = '1') then
			
			loop
			count_int <= count_int(width-2 downto 0) & feedback;
			
			if (count_int = "100") then 
				count_int <= "001";
			end if;		
			if (count_int /= "000") or (count_int /= "111") then 
				exit;
			end if;
			end loop;
			
        	end if;
	end if;
        count <= count_int;
    end process;
    
end Behavioral;
