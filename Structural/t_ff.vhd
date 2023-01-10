library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity t_ff is
		PORT(
				out_comp, t_i, res, clk     : IN STD_LOGIC;
				k                           : OUT STD_LOGIC
				);
end t_ff;

architecture Behavioral10 of t_ff is
SIGNAL K_Y : STD_LOGIC := '0';
begin
	-- T flip flop 
		process(out_comp, t_i, res,clk)
		begin
			if(t_i = '1') then
				K_Y <= '0';
			elsif(res = '1') then
				K_Y <= '0';
			elsif(rising_edge(out_comp)) then
				K_Y <= '1' xor K_Y;
			end if;
		k <= K_Y;
		end process;

end Behavioral10;

