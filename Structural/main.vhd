library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity main is
		PORT(
				reset, clk, unlock, s_i, btn, data_clk        : IN STD_LOGIC;
				y                                             : OUT STD_LOGIC
				);			
end main;

architecture Behavioral of main is

SIGNAL q                 			: STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
SIGNAL sipo_1            			: STD_LOGIC_VECTOR(7 downto 0):= (others => '0');
SIGNAL sipo_1_res        			: STD_LOGIC := '0';
SIGNAL q_d_ff, q_d_ff_and        : STD_LOGIC := '0';
SIGNAL x                         : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL out_mux_4, out_mux_2      : STD_LOGIC;
SIGNAL out_comp                  : STD_LOGIC;
SIGNAL out_cnt_16, sipo_2_res    : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL t_i, res, k_y                  : STD_LOGIC;

begin
	
	t_i <= not unlock;
	res <= not reset;

	CNT24 : ENTITY work.cnt24(Behavioral1)
				PORT MAP(
						q => q,
						clk => clk,
						res => res
						);
						
	BOUNCE : ENTITY work.bounce(Behavioral2)
				PORT MAP(
						btn => btn,
						sipo_1 => sipo_1,
						sipo_1_res => sipo_1_res,
						res => res,
						q => q
						);
						
	RISING_EDGE_SIGNAL : ENTITY work.rising_edge_signal(Behavioral3)
								PORT MAP(
										res => res,
										q => q,
										clk => clk,
										sipo_1_res => sipo_1_res,
										q_d_ff => q_d_ff,
										q_d_ff_and => q_d_ff_and
										);
										
	CNT2 : ENTITY work.cnt2(Behavioral4)
				PORT MAP(
						res => res,
						q_d_ff_and => q_d_ff_and,
						x => x
						);
						
	MUX_4_TO_1 : ENTITY work.mux_4_to_1(Behavioral5)
						PORT MAP(
							q => q,
							x => x,
							out_mux_4 => out_mux_4
							);
	
	MUX_2_TO_1 : ENTITY work.mux_2_to_1(Behavioral6)
						PORT MAP(
							q => q,
							k => k_y,
							out_mux_4 => out_mux_4,
							out_mux_2 => out_mux_2
							);
							
	CNT16 : ENTITY work.cnt16(Behavioral7)
				PORT MAP(
					res => res,
					out_comp => out_comp,
					out_mux_2 => out_mux_2,
					out_cnt_16 => out_cnt_16
					);
					
	COMP : ENTITY work.comp(Behavioral8)
				PORT MAP(
						sipo_2_res => sipo_2_res,
						out_cnt_16 => out_cnt_16,
						out_comp => out_comp
						);
						
	SIPO : ENTITY work.sipo(Behavioral9)
				PORT MAP(
						res => res,
						data_clk => data_clk,
						s_i => s_i,
						sipo_2_res => sipo_2_res
						);
					
	T_FF : ENTITY work.t_ff(Behavioral10)
				PORT MAP(
						k => k_y,
						res => res,
						out_comp => out_comp,
						t_i => t_i,
						clk => clk
					);
				
		y <= k_y;
										


end Behavioral;

