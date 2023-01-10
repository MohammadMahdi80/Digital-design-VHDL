library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_4_to_1 is
		PORT(
				x          : IN STD_LOGIC_VECTOR(1 downto 0);
				q          : IN STD_LOGIC_VECTOR(23 downto 0);
				out_mux_4  : OUT STD_LOGIC
				);
end mux_4_to_1;

architecture Behavioral5 of mux_4_to_1 is

begin
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
		  end process;
		  

end Behavioral5;

