library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sipo is
		PORT(
				data_clk, res, s_i            : IN STD_LOGIC;
				sipo_2_res                    : OUT STD_LOGIC_VECTOR(15 downto 0)
				);
end sipo;

architecture Behavioral9 of sipo is
SIGNAL SI : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
begin
	-- sipo for signal s_i
		process(data_clk, res)
		begin
			if(res = '1') then
				sipo_2_res <= (others => '0');
			elsif(rising_edge(data_clk)) then
				SI(15 downto 1) <= SI(14 downto 0);
				SI(0) <= s_i;
			end if;
		sipo_2_res <= SI;
		end process;

end Behavioral9;

