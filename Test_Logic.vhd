library IEEE;
use ieee.std_logic_1164.all;

entity TestLogic is
generic(
        width : Natural := 3 -- 
    );
    	port (	
	   clk     : in  std_logic;
           en      : in  std_logic;
           rst     : in  std_logic;
	   
           roll    : in  std_logic;
           seed0   : in  std_logic_vector (width -1 downto 0);
	   seed1   : in  std_logic_vector (width -1 downto 0);
	   Sum     : Out std_logic_vector (width    downto 0);
	   
	   Sp      : in  std_logic;
	   Eq      : Out std_logic;
		
	   Data_Out : out std_logic_vector (width downto 0)
	);
end TestLogic;
 
Architecture structural of TestLogic is
-----------------------------------------------
component MultiAdder
    	port (	
		A       : In  std_logic_vector(width -1 downto 0);
		B       : In  std_logic_vector(width -1 downto 0);
		Sum     : Out std_logic_vector(width    downto 0)	 	
	);
end component;
------------------------------------------------
component Counter
    	Port ( clk      : in std_logic;
               en       : in std_logic;
               rst      : in std_logic;
	       roll     : in std_logic;
               seed     : in std_logic_vector  (width -1 downto 0);
               count    : out std_logic_vector (width -1 downto 0)
	);
end component;
-----------------------------------------------
component Point_register
    	Port (
	       clk      : in  std_logic;
               rst      : in  std_logic;
	       Sp       : in  std_logic;
               Data_In  : in  std_logic_vector (width downto 0);
               Data_Out : out std_logic_vector (width downto 0)
	);
end component;
-----------------------------------------------
component comparator
    	Port ( clk      : in  std_logic;
               CompA    : in  STD_LOGIC_VECTOR (width    downto 0);
               CompB    : in  STD_LOGIC_VECTOR (width    downto 0);
               Eq       : out STD_LOGIC
	);
end component;
-----------------------------------------------
	   signal Cnt0  : std_logic_vector(width -1 downto 0):= (others => '0');
	   signal Cnt1  : std_logic_vector(width -1 downto 0):= (others => '0');
	   signal DatIn : std_logic_vector(width    downto 0):= (others => '0');
	   signal DatOut: std_logic_vector(width    downto 0):= (others => '0');
	   signal Sum0  : std_logic_vector(width    downto 0);

Begin
	Data_Out <= DatOut;
	Sum <= Sum0;

	Counter0:    	     Counter             port map (clk => clk , en    => en    , rst   => rst   , roll    => roll , seed     => seed0, count => cnt0 );
	Counter1:    	     Counter             port map (clk => clk , en    => en    , rst   => rst   , roll    => roll , seed     => seed1, count => cnt1 );
	MultiAdder0: 	     MultiAdder          port map (A   => cnt0, B     => cnt1  , Sum   => Sum0 );
	Point_register0:     Point_register      port map (clk => clk , rst   => rst   , Sp    => Sp    , Data_In => DatIn, Data_Out => DatOut);
	comparator0:         comparator          port map (clk => clk , CompA => DatOut, CompB => Sum0  , Eq      => Eq );

end structural; 
