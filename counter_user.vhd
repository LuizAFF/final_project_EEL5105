library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_user is 
	port	(
			R, E, Clock: in std_logic;
			counter: out std_logic_vector(3 downto 0);
			tc: out std_logic
			);
end entity;

architecture bhv of counter_user is
	
	signal count: std_logic_vector(3 downto 0);
	
	begin
		process(clock, E, R)
		begin
			if (R = '1') then
				count <= "0000";
			elsif (rising_edge(clock)) then
				if (E = '1') then
					count <= count + 1;
					if (count = "0111") then
						count <= "0000";
						tc <= '1';
					else
						tc <= '0';
					end if;
				end if;
			end if;
		end process;
		counter <= count;
end architecture;
	