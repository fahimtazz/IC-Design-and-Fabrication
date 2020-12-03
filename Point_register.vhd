library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Point_register is
    generic( width : integer := 3 );

    Port ( clk : in std_logic;
           rst : in std_logic;
	   Sp  : in std_logic;
	
           Data_In  : in  std_logic_vector(width downto 0);
           Data_Out : out std_logic_vector(width downto 0)
	);

end Point_register;
    
architecture slice of Point_register is
    signal Data : std_logic_vector(width downto 0):= (others => '0');
begin
    process(rst, Sp)
    begin
        if rst = '1'  then
	    Data_Out <= (others => '0');     
        elsif sp = '1' and rst = '0'  then
            Data_Out <= Data_In;      
        end if;
    end process;
end slice;



--	process(rst, Sp)
--        if rst = '1' then
--	    	Data <= (others => '0');     
--       	elsif sp = '1' and rst = '0' then
--         	Data <= Data_In;      
--       	end if;
--	Data_Out <= Data;
--	end process;