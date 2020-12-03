library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
    Port ( clk      : in  STD_LOGIC;           

	   D7       : in  STD_LOGIC;
	   D711     : in  STD_LOGIC;
	   D2312    : in  STD_LOGIC;

	   Eq1       : in  STD_LOGIC;
	   roll0     : out STD_LOGIC;
	   Sp       : out STD_LOGIC;

	   rst      : in  STD_LOGIC;
	   Enter    : in  STD_LOGIC;
           
	   win      : out STD_LOGIC;
	   lose     : out STD_LOGIC
);
end fsm;

architecture Behavioral of fsm is
------------------------------------------------
component Data_path
generic( width : Natural := 3 );
    	port (	
	   clk      : in  std_logic;
           en       : in  std_logic;
           rst      : in  std_logic;
	   
           roll     : in  std_logic;
	   
	   Sp       : in  std_logic;
	   Eq       : Out std_logic;

	   D7       : Out std_logic;
	   D711     : Out std_logic;
	   D2312    : Out std_logic
	);
end component;
-----------------------------------------------

    	TYPE STATE_TYPE IS (Start, Play, EndGame);
    	SIGNAL state   : STATE_TYPE;
	SIGNAL Track   : STD_LOGIC:='0';
	SIGNAL En      : STD_LOGIC:='0';
	SIGNAL Sp1     : STD_LOGIC:='0';
	SIGNAL win1    : STD_LOGIC:='0';
	SIGNAL lose1   : STD_LOGIC:='0';

	SIGNAL D70      : STD_LOGIC;
	SIGNAL D7110    : STD_LOGIC;
	SIGNAL D23120   : STD_LOGIC;
	SIGNAL roll     : STD_LOGIC;
	SIGNAL Eq       : STD_LOGIC;
begin

	D70    <=  D70  ;
	D7110  <=  D7110;
	D23120 <=  D23120;
	roll0  <=  roll;
  	Eq     <=  Eq1;

	Sp     <=  Sp1;
	win    <=  win1;
	lose   <=  lose1;

	Data_path0: Data_path port map (clk=>clk, en=>En, rst=>rst, roll=>roll, Sp=>Sp1, Eq=>Eq, D7=>D70, D711=>D7110, D2312=>D23120);

   -- Define the progression of states
    PROCESS(clk, rst)
    BEGIN
	    sp   <= '0'; 
	    En   <= '0';
            win  <= '0'; 
	    lose <= '0';
	
        IF rst = '1' THEN
	    sp    <= '0'; 
	    En   <= '0';
            win1  <= '0'; 
	    lose1 <= '0';
	    Track <= '0';
	    roll <= '0';
	    state <= start;
		
        ELSIF (clk'EVENT AND clk = '1') THEN
	    En <= '1';

            CASE state IS
		WHEN Start=>
                    if ENTER = '1' THEN
			En    <= '1';
			state <= play;
                    END IF;

                WHEN Play=>
                    if win1 = '1' or lose1 = '1' THEN
			state <= EndGame;
                    ELSIF track= '0' and ENTER = '0' THEN 
			sp1   <= '1';
			roll <= '1';
			-- roll the dice

			if D7 = '1' or D711 = '1' then
				win1 <= '1';
				lose1<= '0';
				state <= EndGame;
			elsif D2312 = '1' then
				win1 <= '0';
				lose1<= '1';
				state <= EndGame;
			else 
				Track <= '1';
			end if;
	     
		    ELSIF track= '1' and ENTER = '0' THEN
			sp1   <= '0';
			roll <= '1';
			-- roll the dice
			
			if D7 = '1'  then
				win1 <= '0';
				lose<= '1';
				state <= EndGame;
			elsif eq = '1' then
				win1 <= '1';
				lose1<= '0';
				state <= EndGame;
			end if;

                    END IF;                    
                WHEN EndGame=>
		    track <= '0';
		    EN    <= '0';                                 
            END CASE;
        END IF; 
    END PROCESS;



end Behavioral;

