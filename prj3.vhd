library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity prj2 is
	PORT(
			unlock, btn, clk, reset, s_i, data_clk    :    IN  STD_LOGIC;
			cnt                                       :    OUT STD_LOGIC_VECTOR(23 downto 0);
			y,t_i1,res1,sipo_1_res1,q_d_ff1 ,q_d_ff_and1,out_mux_41,out_mux_21,out_comp1  :    OUT STD_LOGIC ;
			sipo_11 : out std_logic_vector(7 downto 0);
			x1 : out std_logic_vector(1 downto 0);
			out_cnt_161, sipo_2_res1 : out std_logic_vector(15 downto 0)	
			);            
end prj2;


architecture Behavioral of prj2 is

SIGNAL t_i, k, res	   			:  STD_LOGIC := '0';
SIGNAL q                 			:  STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
SIGNAL sipo_1        	 			:  STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
SIGNAL sipo_1_res   	      		:  STD_LOGIC := '0';
SIGNAL q_d_ff							:  STD_LOGIC := '0';   
SIGNAL q_d_ff_and        			:  STD_LOGIC := '0'; 
SIGNAL x                 			:  STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
SIGNAL out_mux_4,out_mux_2			:  STD_LOGIC := '0';
SIGNAL out_cnt_16, sipo_2_res		:  STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
SIGNAL out_comp        			   :  STD_LOGIC := '0';
 


begin
		t_i <= not unlock;
		res <= not reset;
		res1 <= res;
		t_i1 <= t_i;
		
		-- dividing clk
		process(res, clk)
		begin
				if(res = '1') then
					q <= (others => '0');
					
				elsif(rising_edge(clk)) then 
					q <= q +1;
				end if; 
		end process;
		cnt <= q;
		
		-- ignore bounce of button
		process(res, q(15))
		variable v : std_logic := '0';
		begin
				if(res = '1') then
					sipo_1 <= x"00";
				elsif(rising_edge(q(15))) then
					sipo_1(7 downto 1) <= sipo_1(6 downto 0);
					sipo_1(0) <= btn;
					v := sipo_1(0);
					for i in 0 to 7 loop
						v := v and sipo_1(i);
					end loop;
				
					if(v = '1') then
						sipo_1_res <= '1';
					else
						sipo_1_res <= '0';
					end if;
				end if;
		end process;
		sipo_11 <= sipo_1;
		sipo_1_res1 <= sipo_1_res;
		
		-- create rising edge sensitive for signal "sipi_1_res"
		process(res, q(15), sipo_1_res)
		begin
				if(res = '1') then
					q_d_ff <= '0';
				elsif(rising_edge(q(15))) then
					q_d_ff <= sipo_1_res;
				end if;
				q_d_ff_and <= (not q_d_ff) and sipo_1_res;
		end process;
		q_d_ff1 <= q_d_ff;
		q_d_ff_and1 <= q_d_ff_and;
		
		-- counter for select multiplexer
		process( res, q_d_ff_and)
		begin
				if(res = '1') then
					x <= "00";
				elsif(rising_edge(q_d_ff_and)) then
					x <= x + 1;
				end if;
		end process;
		x1 <= x;
		
		-- mux 4 to 1
		process(x, q)
		begin
			case x is
				when "00" =>
					out_mux_4 <= q(20);
				when "01" =>
					out_mux_4 <= q(15);
				when "10" =>
					out_mux_4 <= q(10);
				when "11" =>
					out_mux_4 <= q(5);
				when others => 
                out_mux_4 <= 'X';
			end case;
			out_mux_41 <= out_mux_4;
		  end process;
		  
		  
		  -- mux 2 to 1
		  process(k, q)
		  begin
				case k is
					when '0' =>
						out_mux_2 <= out_mux_4;
					when '1' =>
						out_mux_2 <= '0';
					when others =>
						out_mux_2 <= 'X';
				end case;
			out_mux_21 <= out_mux_2;
		  end process;
		  
		  
		  -- counter 16 bit			
			process(res, out_comp, out_mux_2)
			begin
				if(res = '1' or out_comp = '1') then
					out_cnt_16 <= (others => '0');
					
				elsif(rising_edge(out_mux_2)) then 
					out_cnt_16 <= out_cnt_16 +1;
				end if; 
			end process;
			out_cnt_161 <= out_cnt_16;
			
			
		-- comparator
		process(out_cnt_16, sipo_2_res)
		variable v : std_logic;
		begin
		v := out_cnt_16(0) xnor sipo_2_res(0);
			for i in 1 to 15 loop
				v := v and (out_cnt_16(i) xnor sipo_2_res(i));
			end loop;
			out_comp <= v;
		end process;
		out_comp1 <= out_comp;
		
		-- sipo for signal s_i
		process(data_clk, res)
		begin
			if(res = '1') then
				sipo_2_res <= (others => '0');
			elsif(rising_edge(data_clk)) then
				sipo_2_res(15 downto 1) <= sipo_2_res(14 downto 0);
				sipo_2_res(0) <= s_i;
			end if;
		end process;
		sipo_2_res1 <= sipo_2_res;
		
		-- T flip flop 
		process(out_comp, t_i, res,clk)
		begin
			if(t_i = '1') then
				k <= '0';
			elsif(res = '1') then
				k <= '0';
			elsif(rising_edge(out_comp)) then
				k <= '1' xor k;
			end if;
			y <= k;
		end process;
		
		
			
		
end Behavioral;

