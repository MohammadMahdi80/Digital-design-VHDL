library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity cnt2 is
		PORT(
				res, q_d_ff_and        : IN STD_LOGIC;
				x                      : OUT STD_LOGIC_VECTOR(1 downto 0)
				);
end cnt2;

architecture Behavioral4 of cnt2 is
SIGNAL CNT : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
begin
		-- counter for select multiplexer
		process( res, q_d_ff_and)
		begin
				if(res = '1') then
					CNT <= "00";
				elsif(rising_edge(q_d_ff_and)) then
					CNT <= CNT + 1;
				end if;
		x <= CNT;
		end process;

end Behavioral4;

