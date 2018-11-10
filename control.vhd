library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control is
	port	(	
			R, SEL: out std_logic_vector(1 downto 0);
			E: out std_logic_vector(4 downto 0);
			BTN: in std_logic_vector(2 downto 0);
			clock: in std_logic;
			sw_error, end_game, end_time, end_round, win0, win1: in std_logic
			);
end control;

architecture bhv of control is
	type STATES is (start, setup, play, result, check, next_round, wait_state);
	signal n_state, c_state: STATES;
	--signal BTN(0), BTN(1), BTN(2): std_logic;
	
	begin
		--BTN(0): BTN(0);
		--BTN(1): BTN(1);
		--BTN(2): BTN(2);
		
		process(clock, BTN(0))
			begin
				if (BTN(0) = '0') then
					c_state <= start;
				elsif (clock'event AND clock = '1') then
					c_state <= n_state;
				end if;
		end process;
		
		process(n_state, BTN(0), BTN(1), BTN(2))
			begin
				case c_state is
					when start =>
						R <= "11";
						E <= "00000";
						SEL <= "00";
						if BTN(1) = '1' then
							n_state <= start;
						elsif BTN(1) = '0' then
							n_state <= setup;
						end if;
						
					when setup =>
						R <= "00";
						E <= "01100";
						SEL <= "00";
						if BTN(0) = '0' then
							n_state <= start;
						elsif BTN(1) = '1' then
							n_state <= setup;
						elsif BTN(1) = '0' then
							n_state <= play;
						end if;
						
					when play =>
						R <= "00";
						E <= "01111";
						SEL <= "01";
						if BTN(0) = '0' then
							n_state <= start;
						elsif (BTN(2) = '1' AND end_time = '0' AND BTN(0) = '1') then
							n_state <= play;
						elsif (BTN(2) = '0' AND end_time = '0' AND BTN(0) = '1') then
							n_state <= check;
						elsif (end_time = '1') then
							n_state <= result;
						end if;
						
					when check =>
						R <= "00";
						E <= "10011";
						SEL <= "01"; --talvez esteja errado
						if BTN(0) = '0' then
							n_state <= start;
						elsif (end_game = '0' AND sw_error = '0' AND end_round = '0' AND BTN(0) = '1') then
							n_state <= next_round;
						elsif (end_game = '1' AND BTN(0) = '1') then
							n_state <= result;
						end if;
						
					when next_round =>
						R <= "00";
						E <= "00001";
						SEL <= "01";
						if BTN(0) = '0' then
							n_state <= start;
						end if;
						
					when result =>
						R <= "00";
						E <= "10100";
						SEL <= "11";
						if (BTN(0) = '0' or BTN(1) = '0') then
							n_state <= start;
						end if;
						
					when wait_state =>
						R <= "00";
						E <= "00100";
						SEL <= "10";
						if BTN(0) = '0' then
							n_state <= start;
						elsif (BTN(0) = '1' AND BTN(1) = '0') then
							n_state <= play;
						end if;
					
					when others =>
						n_state <= start;
				end case;		
		end process;
end bhv;
						
						