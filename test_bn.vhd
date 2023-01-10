LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_bn IS
END test_bn;
 
ARCHITECTURE behavior OF test_bn IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT prj2
    PORT(
         unlock : IN  std_logic;
         btn : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         s_i : IN  std_logic;
         data_clk : IN  std_logic;
         cnt : OUT  std_logic_vector(23 downto 0);
         y : OUT  std_logic;
         t_i1 : OUT  std_logic;
         res1 : OUT  std_logic;
         sipo_1_res1 : OUT  std_logic;
         q_d_ff1 : OUT  std_logic;
         q_d_ff_and1 : OUT  std_logic;
         out_mux_41 : OUT  std_logic;
         out_mux_21 : OUT  std_logic;
         out_comp1 : OUT  std_logic;
         sipo_11 : OUT  std_logic_vector(7 downto 0);
         x1 : OUT  std_logic_vector(1 downto 0);
         out_cnt_161 : OUT  std_logic_vector(15 downto 0);
         sipo_2_res1 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal unlock : std_logic := '0';
   signal btn : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal s_i : std_logic := '0';
   signal data_clk : std_logic := '0';

 	--Outputs
   signal cnt : std_logic_vector(23 downto 0);
   signal y : std_logic;
   signal t_i1 : std_logic;
   signal res1 : std_logic;
   signal sipo_1_res1 : std_logic;
   signal q_d_ff1 : std_logic;
   signal q_d_ff_and1 : std_logic;
   signal out_mux_41 : std_logic;
   signal out_mux_21 : std_logic;
   signal out_comp1 : std_logic;
   signal sipo_11 : std_logic_vector(7 downto 0);
   signal x1 : std_logic_vector(1 downto 0);
   signal out_cnt_161 : std_logic_vector(15 downto 0);
   signal sipo_2_res1 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
   constant data_clk_period : time := 0.5 ms;
 
BEGIN
	reset <= '0', '1' after 0.5 ms;
	btn <= '0', '1' after 327 us, '0' after 1.58 ms, '1' after 1.88 ms, '0' after 3 ms,'1' after 3.3 ms, '0' after 5 ms;
	unlock <= '1', '0' after 10.27 ms, '1' after 10.8 ms;
	-- Instantiate the Unit Under Test (UUT)
   uut: prj2 PORT MAP (
          unlock => unlock,
          btn => btn,
          clk => clk,
          reset => reset,
          s_i => s_i,
          data_clk => data_clk,
          cnt => cnt,
          y => y,
          t_i1 => t_i1,
          res1 => res1,
          sipo_1_res1 => sipo_1_res1,
          q_d_ff1 => q_d_ff1,
          q_d_ff_and1 => q_d_ff_and1,
          out_mux_41 => out_mux_41,
          out_mux_21 => out_mux_21,
          out_comp1 => out_comp1,
          sipo_11 => sipo_11,
          x1 => x1,
          out_cnt_161 => out_cnt_161,
          sipo_2_res1 => sipo_2_res1
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
