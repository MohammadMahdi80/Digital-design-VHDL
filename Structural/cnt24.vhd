library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cnt24 is
		PORT(
				clk, res            :  IN STD_LOGIC;
				q                   :  OUT STD_LOGIC_VECTOR(23 downto 0)
				);
end cnt24;

architecture Behavioral1 of cnt24 is
SIGNAL CNT : STD_LOGIC_VECTOR(23 DOWNTO 0) := (others => '0');
begin
	process(res, clk)
		begin
				if(res = '1') then
					CNT <= (others => '0');
					
				elsif(rising_edge(clk)) then 
					CNT <= CNT + 1;
				end if; 
			q <= CNT;
		end process;
end Behavioral1;

