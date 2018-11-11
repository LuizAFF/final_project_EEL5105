library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity frequency_divider is
	port ( 	
			reset, enable, clock: in std_logic;
			Sel: in std_logic_vector(1 downto 0);
			Output: out std_logic
			);
			
end entity;

architecture top of frequency_divider is
	
	component multiplexer is
		port	(
				a, b, c, d: in std_logic; 
				Sel : in std_logic_vector(1 downto 0);
				Output : out std_logic
				);
	end component;

	signal counter: std_logic_vector(27 downto 0);	-- registra valor da contagem
	signal clock_05hz, clock_1hz, clock_2hz, clock_4hz: std_logic;
	begin
		P1: process(clock, reset, counter)
		begin
			if reset= '0' then
				counter <= x"0000000";
			elsif rising_edge(clock) then
				if enable = '0' then
				
					counter <= counter + 1;
				
				end if;

				if (counter = x"17D783F" OR counter = x"2FAF07F" OR counter = x"5F5E0FF" OR counter = x"BEBC1FF") then --4hz
					clock_4hz <= '1';
				else
					clock_4hz <= '0';
				end if;

				if (counter = x"2FAF07F" OR counter = x"5F5E0FF" OR counter = x"BEBC1FF") then --2hz
					clock_2hz <= '1';
				else
					clock_2hz <= '0';
				end if;

				if (counter = x"5F5E0FF" OR counter = x"BEBC1FF") then --1hz
					clock_1hz <= '1';
				else
					clock_1hz <= '0';
				end if;

				if counter = x"BEBC1FF" then --0.5hz
					counter <= x"0000000";
					clock_05hz <= '1';
				else
					clock_05hz <= '0';
				end if;
			end if;
		end process;
	
	--clock_05hz_4bits <= "000" & clock_05hz;
	--clock_1hz_4bits <= "000" & clock_1hz;
	--clock_2hz_4bits <= "000" & clock_2hz;
	--clock_4hz_4bits <= "000" & clock_4hz;
	mux: multiplexer generic map(BUS_WIDTH => 1)
			 port map (clock_05hz, clock_1hz, clock_2hz, clock_4hz, Sel, Output);
	
end architecture;
