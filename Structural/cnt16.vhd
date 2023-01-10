library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity cnt16 is
		PORT(
				res, out_comp, out_mux_2       : IN STD_LOGIC;
				out_cnt_16                     : OUT STD_LOGIC_VECTOR(15 downto 0)
				);
				
end cnt16;

architecture Behavioral7 of cnt16 is
SIGNAL CNT : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
begin
		-- counter 16 bit			
			process(res, out_comp, out_mux_2)
			begin
				if(res = '1' or out_comp = '1') then
					CNT <= (others => '0');
					
				elsif(rising_edge(out_mux_2)) then 
					CNT <= CNT +1;
				end if; 
			out_cnt_16 <= CNT;
			end process;

end Behavioral7;

