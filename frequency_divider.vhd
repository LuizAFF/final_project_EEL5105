library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity frequency_divider is
	port ( 	
			option: in std_logic_vector(1 downto 0); --option from the input: 00 stands for 0.5Hz, and it is doubled as the option number increases by 1
			reset: in std_logic;
			clock: in std_logic;
			chosen_clock: out std_logic
			);
			
end frequency_divider;

architecture top of frequency_divider is
	signal counter: std_logic_vector(27 downto 0);	-- registra valor da contagem
	begin
		P1: process(clock, reset, counter)
		begin
			if reset= '0' then
				counter <= x"0000000“;
			elsif clock'event and clock= ‘1' then
				counter <= counter + 1;
				if option = "00" then
					if counter = x"17D783F" then
						counter <= x"0000000";
						chosen_clock <= '1';
					else
						chosen_clock <= '0';
					end if;
				elsif option = "01" then
					if counter = x"2FAF07F" then
						counter <= x"0000000";
						chosen_clock <= '1';
					else
						chosen_clock <= '0';
					end if;
				elsif option = "10" then
					if counter = x"5F5E0FF" then
						counter <= x"0000000";
						chosen_clock <= '1';
					else
						chosen_clock <= '0';
					end if;
				else
					if counter = x"BEBC1FF" then
						counter <= x"0000000";
						chosen_clock <= '1';
					else
						chosen_clock <= '0';
					end if;
				end if;
			end if;
		end process;
	end top;