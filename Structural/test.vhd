LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         unlock : IN  std_logic;
         s_i : IN  std_logic;
         btn : IN  std_logic;
         data_clk : IN  std_logic;
         y : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal unlock : std_logic := '0';
   signal s_i : std_logic := '0';
   signal btn : std_logic := '0';
   signal data_clk : std_logic := '0';

 	--Outputs
   signal y : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 ns;
   constant data_clk_period : time := 0.5 ms;
 
BEGIN
	reset <= '0', '1' after 0.5 ms;
	btn <= '0', '1' after 327 us, '0' after 1.58 ms, '1' after 1.88 ms, '0' after 3 ms,'1' after 3.3 ms, '0' after 5 ms;
	unlock <= '1', '0' after 11.27 ms, '1' after 11.8 ms;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          reset => reset,
          clk => clk,
          unlock => unlock,
          s_i => s_i,
          btn => btn,
          data_clk => data_clk,
          y => y
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   data_clk_process :process
	variable j : natural range 0 to 18 := 0;
   begin
		if(j = 0) then
			data_clk <= '0';
			wait for 10*data_clk_period/2 + 0.01 ms;
			j := j+1;
		elsif(j < 17) then
			data_clk <= '0';
			wait for data_clk_period/2;
			data_clk <= '1';
			wait for data_clk_period/2;
			j := j+1;
		else 
			data_clk <= '0';
			wait for 1000 ms;
		end if;
   end process;
	
	s_i_signal : process(data_clk)
	variable v : std_logic_vector(14 downto 0) := B"100110101001011";
	variable i : natural range 0 to 15 := 0;
	begin
		if(rising_edge(data_clk)) then
			if (i /= 15) then
				s_i <=  v(i);
				i := i + 1;
			else 
				s_i <= '0';
			end if;
		end if;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
