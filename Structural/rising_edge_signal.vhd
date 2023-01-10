library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity rising_edge_signal is
		PORT(
				res, clk, sipo_1_res     : IN STD_LOGIC;
				q                        : IN STD_LOGIC_VECTOR(23 downto 0);
				q_d_ff, q_d_ff_and       : OUT STD_LOGIC
				);
end rising_edge_signal;

architecture Behavioral3 of rising_edge_signal is
SIGNAL QDFFAND : STD_LOGIC := '0';
SIGNAL QDFF    : STD_LOGIC := '0';
begin
		-- create rising edge sensitive for signal "sipi_1_res"
		process(res, clk, sipo_1_res)
		begin
				if(res = '1') then
					QDFF <= '0';
				elsif(rising_edge(q(15))) then
					QDFF <= sipo_1_res;
				end if;
				q_d_ff <= QDFF;
				q_d_ff_and <= QDFFAND;
				QDFFAND <= (not QDFF) and sipo_1_res;
		end process;

end Behavioral3;

