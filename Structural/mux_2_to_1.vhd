library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_2_to_1 is
		PORT(
				k, out_mux_4          : IN STD_LOGIC;
				q                     : IN STD_LOGIC_VECTOR(23 downto 0);
				out_mux_2             : OUT STD_LOGIC
				);
				
end mux_2_to_1;

architecture Behavioral6 of mux_2_to_1 is

begin
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
		  end process;


end Behavioral6;

