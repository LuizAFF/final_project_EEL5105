library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity main is
	port	(	
			SW: in std_logic_vector(9 downto 0);
			BTN: in std_logic_vector(3 downto 0);
			CLOCK_50: in std_logic;
			KEY: in std_logic_vector(3 downto 0);
			LEDR: out std_logic_vector(9 downto 0);
			HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0)
			);
end main;

architecture top of main is

	component control is
		port	(	
				R, SEL: out std_logic_vector(1 downto 0);
				E: out std_logic_vector(4 downto 0);
				BTN: in std_logic_vector(2 downto 0);
				clock: in std_logic;
				sw_error, end_game, end_time, end_round, win0, win1: in std_logic
				);
	end component;
	
	component datapath is
		port	(
				R: in std_logic_vector(1 downto 0);
				E: in std_logic_vector(4 downto 0);
				SEL: in std_logic_vector(1 downto 0);
				clock: in std_logic;
				sw_error, end_game, end_time, win0, win1: out std_logic
				);
	end component;
	
	component buttonSync is
		port	(
				KEY0, KEY1, KEY2, KEY3, CLK: in std_logic;
				BTN0, BTN1, BTN2, BTN3: out std_logic;
				);
	end component;

	signal	BTN, timer, roundmsb, roundlsb: std_logic_vector(3 downto 0);
				linha, coluna: std_logic_vector(2 downto 0);
				linha7seg, coluna7seg, timer7seg, roundmsb7seg, roundlsb7seg: std_logic_vector(6 downto 0);
				
	begin
		
		--display2_01:	decod7seg port map ('0' & coluna, coluna7seg);
		--display2_10:	decod7seg port map (roundlsb, roundlsb7seg);
		--display3_01:	decod7seg port map ('0' & linha, linha7seg);
		--display3_10:	decod7seg port map (roundmsb, roundmsb7seg);
		--display4:	decod7seg port map (timer, timer7seg);
		
		--multiplexadores dos HEX(5 downto 0): transformar numa entity separada
		HEX0
		HEX1	<=	"1000111" when SEL = "00" else
					"1000001" when SEL = "01" else
					"1000001" when SEL = "10" else
					"1111111";
					
		HEX2	<=	"1111111" when SEL = "00" else
					coluna7seg when SEL = "01" else
					roundlsb7seg when SEL = "10" else
					"0101111";
					
		HEX3	<=	"1111111" when SEL = "00" else
					linha7seg when SEL = "01" else
					roundmsb7seg when SEL = "10" else
					"0000110";
					
		HEX4	<=	"1111111" when SEL = "00" else
					timer7seg when SEL = "01" else
					"0100001" when SEL = "10" else
					"0010010";
					
		HEX5	<=	"1111111" when SEL = "00" else
					"0000111" when SEL = "01" else
					"0101111" when SEL = "10" else
					"0000001";
					
		--Leds de 0 a 9:
		LEDR(9 downto 0)	<=	'0' & LEDR(8 downto 5) & '0' & LEDR(3 downto 0);
		
		
end top;