library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bounce is
		PORT(
				res,btn          : IN STD_LOGIC;
				q                : IN STD_LOGIC_VECTOR(23 downto 0);
				sipo_1           : OUT STD_LOGIC_VECTOR(7 downto 0):= (others => '0');
				sipo_1_res       : OUT STD_LOGIC := '0'
				);
end bounce;

architecture Behavioral2 of bounce is
SIGNAL SP : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
begin
		-- ignore bounce of button
		process(res, q(15))
		variable v : std_logic := '0';
		begin
				if(res = '1') then
					SP <= x"00";
				elsif(rising_edge(q(15))) then
					SP(7 downto 1) <= SP(6 downto 0);
					SP(0) <= btn;
					v := SP(0);
					for i in 0 to 7 loop
						v := v and SP(i);
					end loop;
				
					if(v = '1') then
						sipo_1_res <= '1';
					else
						sipo_1_res <= '0';
					end if;
				end if;
			sipo_1 <= SP;
		end process;

end Behavioral2;

