library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control is
	port	(	
			R, SEL: out std_logic_vector(1 downto 0);
			E: out std_logic_vector(4 downto 0);
			BTN: in std_logic_vector(3 downto 0);
			clock: in std_logic;
			sw_error, end_game, end_time, win0, win1: in std_logic
			);
end control;

architecture bhv of control is
	type STATES is (start, setup, play, result, check, next_round, wait_state);
	signal n_state, c_state: STATES;
	
	begin
		
		P1: process(clock, BTN(0))
			begin
				if (BTN(0) = '0') then
					c_state <= start;
				elsif rising_edge(clock) then
					c_state <= n_state;
				end if;
		end process;
		
		P2: process(BTN(1), BTN(2), sw_error, end_game, end_time, win0, win1, clock)
			begin
				case c_state is
					when start =>
						R <= "11";
						E <= "00000";
						SEL <= "00";
						if (BTN(1) = '1') then
							n_state <= c_state;
						else
							n_state <= setup;
						end if;
						
					when setup =>
						R <= "00";
						E <= "01100";
						SEL <= "00";
						if BTN(1) = '0' then
							n_state <= play;
						else
							n_state <= c_state;
						end if;
						
					when play =>
						R <= "00";
						E <= "10111";
						SEL <= "01";
						if (BTN(2) = '0' AND end_time = '0') then
							n_state <= check;
						elsif (end_time = '1') then
							n_state <= result;
						else
							n_state <= c_state;
						end if;
						
					when check =>
						R <= "00";
						E <= "00011";
						SEL <= "01";
						if (end_game = '0' AND sw_error = '0' AND end_time = '0') then
							n_state <= next_round;
						else
							n_state <= result;
						end if;
						
					when next_round =>
						R <= "00";
						E <= "00001";
						SEL <= "01";
						--if BTN(0) = '0' then
							n_state <= wait_state;
						--end if;
						
					when result =>
						R <= "00";
						E <= "00100";
						SEL <= "11";
						if (BTN(1) = '0') then
							n_state <= start;
						else
							n_state <= c_state;
						end if;
						
					when wait_state =>
						R <= "10";
						E <= "00100";
						SEL <= "10";
						if (BTN(1) = '0') then
							n_state <= play;
						else
							n_state <= wait_state;
						end if;
					
				end case;		
		end process;
end bhv;
						
						
