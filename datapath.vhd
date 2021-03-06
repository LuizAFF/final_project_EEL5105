library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity datapath is
	port	(
			R: in std_logic_vector(1 downto 0);
			E: in std_logic_vector(4 downto 0);
			SEL: in std_logic_vector(1 downto 0);
			clock, fire: in std_logic;
			switches: in std_logic_vector(9 downto 0);
			sw_error, end_game, end_time, win0, win1: out std_logic;
			Leds: out std_logic_vector(9 downto 0);
			Display0, Display1, Display2, Display3, Display4, Display5: out std_logic_vector(6 downto 0)
			);
end entity;

architecture bhv of datapath is
	
	signal MATCH, USER, WIN, CLKHZ: std_logic;
	signal Nivel: std_logic_vector(1 downto 0);
	signal LINHA: std_logic_vector(2 downto 0);
	signal COLUNA, C_TIME: std_logic_vector(3 downto 0);
	signal saida_comparacao, saida_rom0, saida_rom1: std_logic_vector(6 downto 0);
	signal en_ct0, en_ct1, R_ct0, R_ct1, resultado_comparacao: std_logic;
	signal pontuacao0, pontuacao1: std_logic_vector(3 downto 0);
	signal sw_error_s, end_time_s, end_game_s, win0_s, win1_s: std_logic;
	signal line_and_column: std_logic_vector(9 downto 0);
	signal round: std_logic_vector(4 downto 0);
	signal nivel4, user4, win4, linha4, ROUNDLSB, ROUNDMSB: std_logic_vector(3 downto 0);
	signal nivel7seg, user7seg, win7seg, time_7seg, linha_7seg, ROUNDMSB_7seg, coluna_7seg, ROUNDLSB_7seg: std_logic_vector(6 downto 0);
	
	
	component ROM0 is
		port (
				address : in std_logic_vector(2 downto 0);
				data : out std_logic_vector(6 downto 0) 
				);
	end component;
	
	
	component ROM1 is
		port	(
				address : in std_logic_vector(2 downto 0);
				data : out std_logic_vector(6 downto 0) 
				);
	end component;
	
	
	component frequency_divider is
		port	( 	
				reset0, reset1, enable0, enable1, clock: in std_logic;
				Sel: in std_logic_vector(1 downto 0);
				Nivel: out std_logic_vector(1 downto 0);
				Output: out std_logic
				);
	end component;
	
	component decod7seg is
		port	(
				C: in std_logic_vector(3 downto 0);
				F:	out std_logic_vector(6 downto 0)
				);
	end component;
	
	
	component multiplexer is
		generic(WIDTH: positive);
		port	(
				a, b, c, d: in std_logic_vector(WIDTH-1 downto 0); 
				Sel : in std_logic_vector(1 downto 0);
				Output : out std_logic_vector(WIDTH-1 downto 0)
				);
	end component;
	
	
	component counter_user is 
		port	(
				R, E, Clock: in std_logic;
				counter: out std_logic_vector(3 downto 0);
				tc: out std_logic
				);
	end component;
	
	
	component counter_time is 
		port	(
				R, E, Clock: in std_logic;
				counter: out std_logic_vector(3 downto 0);
				tc: out std_logic
				);
	end component;
	
	
	component counter_round is 
		port	(
				R, E, Clock: in std_logic;
				counter: out std_logic_vector(4 downto 0);
				tc: out std_logic
				);
	end component;
	
	
	component comparator2x1 is
		port	(
				A, B: in std_logic_vector(6 downto 0);
				C: out std_logic
				);
	end component;
	
	
	component REGISTRADOR is
		generic (WIDTH: POSITIVE);
		port (
			  CLK: in std_logic;
			  EN: in std_logic;
			  RST: in std_logic;
			  D: in std_logic_vector(WIDTH-1 downto 0);
			  Q: out std_logic_vector(WIDTH-1 downto 0)
			  );
	end component;
	
	
	component multiplexer2x1 is
		generic(WIDTH: Positive);
		port	(
				a, b: in std_logic_vector(WIDTH-1 downto 0); 
				Sel : in std_logic;
				Output : out std_logic_vector(WIDTH-1 downto 0)
				);
		end component;
		
		
	component column_decoder is
		port	(
				input: in std_logic_vector(6 downto 0);
				output: out std_logic_vector(3 downto 0)
				);
	end component;
	
	
	begin
	
		--counter_round logic
		count_r: counter_round port map (R(0), E(2), clock, round, end_game_s);
		end_game <= end_game_s;
		USER <= round(0);
		ROUNDLSB <= round(3 downto 0);
		ROUNDMSB <= "000" & round(4);
	
	
		--logica combinacional do datapath
		--logica A
		R_ct0 <= '1' when (sw_error_s = '1' or end_time_s = '1' or end_game_s = '1') else '0';
		en_ct0 <= (not USER and MATCH);
		counter_user0: counter_user port map (R_ct0, en_ct0, clock, pontuacao0, win0_s);
		win0 <= win0_s;
		
		
		--logica B
		R_ct1 <= '1' when (sw_error_s = '1' or end_time_s = '1' or end_game_s = '1') else '0';
		en_ct1 <= (USER and MATCH);
		counter_user1: counter_user port map (R_ct1, en_ct1, clock, pontuacao1, win1_s);
		win1 <= win1_s;
		
		
		--logica C
		WIN <= (not USER and not win0_s) or win1_s;
		
		
		--comparacao com memorias
		
		reg: REGISTRADOR generic map (WIDTH => 10)
								port map (clock, E(0), R(0), Switches(9 downto 0), line_and_column);
								
		memoria0: ROM0 port map (line_and_column(9 downto 7), saida_rom0);
		memoria1: ROM1 port map (line_and_column(9 downto 7), saida_rom1);
		muxcomparacao: multiplexer2x1 generic map(WIDTH => 7)
												port map(saida_rom0, saida_rom1, USER, saida_comparacao);
		comparacaolinha: comparator2x1 port map(line_and_column(6 downto 0), saida_comparacao, resultado_comparacao);
												
		
		--logica D
		MATCH <= not fire and resultado_comparacao;
		
		
		--decod coluna
		column: column_decoder port map (Switches(6 downto 0), COLUNA);
		
		
		--logica E e D(ou f?)
		
		sw_error <= not fire and (COLUNA(3) OR (NOT COLUNA(2) AND NOT COLUNA(1) AND NOT COLUNA(0)));
		
		
		--frequency_divider logic
		--quando R(0) = '1' ou E(3) = '0' o contador fica em 0 , ou seja, devolver nada porque esta desligado
		--quando R(0) = '0' e E(3) = '1' o contador muda, e o divisor vai funcionar
		fre_div: frequency_divider port map (R(0), R(1), E(3), E(1), clock, SEL, Nivel, CLKHZ);
		
		
		--time counter
		time_counter: counter_time port map (R(1), E(3), CLKHZ, C_TIME);
		
		
		
		--multiplexers from HEX0 to HEX5
		
		
		--HEX5
		disp7seg5: multiplexer generic map (WIDTH => 7)
										port map ("1111111", "0000111", "0101111", "1000001", SEL, Display5);
		
		
		--HEX4
		decod7seg4_01: decod7seg port map (C_TIME, time_7seg);
		disp7seg4:multiplexer generic map (WIDTH => 7)
										port map ("1111111", time_7seg, "0100001", "0010010", SEL, Display4);
		
		
		--HEX3
		linha4 <= '0' & LINHA;
		decod7seg3_01: decod7seg port map (linha4, linha_7seg);
		decod7seg3_10: decod7seg port map (ROUNDMSB, ROUNDMSB_7seg);
		disp7seg3:multiplexer generic map (WIDTH => 7)
										port map ("1111111", linha_7seg, ROUNDMSB_7seg, "1000001", SEL, Display3);
										
		
		--HEX2
		decod7seg2_01: decod7seg port map (COLUNA, coluna_7seg);
		decod7seg2_10: decod7seg port map (ROUNDLSB, ROUNDLSB_7seg);
		disp7seg2:multiplexer generic map (WIDTH => 7)
										port map ("1111111", "0000111", "0101111", "1000001", SEL, Display2);
										
		
		--HEX1
		disp7seg1:multiplexer generic map (WIDTH => 7)
										port map ("1111111", "0000111", "0101111", "1000001", SEL, Display1);
										
		
		--HEX0
		nivel4 <= "00" & Nivel;
		user4 <= "000" & USER;
		win4 <= "000" & WIN;
		nivel7: decod7seg port map (nivel4, nivel7seg);
		user7: decod7seg port map (user4, user7seg);
		win7: decod7seg port map (win4, win7seg);
		disp7seg0: multiplexer	generic map (WIDTH => 7)
										port map (nivel7seg, user7seg, user7seg, win7seg, SEL, Display0);
		
		Leds <= '0' & pontuacao1 & '0' & pontuacao0;
	
end architecture;
	