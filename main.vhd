library ieee;
use ieee.std_logic_1164.all;

entity main is
	port	(	
			SW: in std_logic_vector(9 downto 0);
			Clock_50: in std_logic;
			KEY: in std_logic_vector(3 downto 0);
			LEDR: out std_logic_vector(9 downto 0);
			HEX0: out std_logic_vector(6 downto 0);
			HEX1: out std_logic_vector(6 downto 0);
			HEX2: out std_logic_vector(6 downto 0);
			HEX3: out std_logic_vector(6 downto 0);
			HEX4: out std_logic_vector(6 downto 0);
			HEX5: out std_logic_vector(6 downto 0)
			);
end main;

architecture top of main is

	component ROM0 is
		port (
				address : in std_logic_vector(2 downto 0);
				data : out std_logic_vector(6 downto 0) 
				);
	end component;
	
	
	component ROM1 is
		port (
				address : in std_logic_vector(2 downto 0);
				data : out std_logic_vector(6 downto 0) 
				);
	end ROM0;
	
	
	component buttonSync is
		port	(
				KEY0, KEY1, KEY2, KEY3, CLK: in std_logic;
				BTN0, BTN1, BTN2, BTN3: out std_logic	
				);
	end component;
	
	
	component frequency_divider is
		port	( 	
				option: in std_logic_vector(1 downto 0); --option from the input: 00 stands for 0.5Hz, and it is doubled as the option increases by 1
				reset: in std_logic;
				clock: in std_logic;
				chosen_clock: out std_logic
				);
	end component;
	
	
	component decod7seg is
		port	(
				C: in std_logic_vector(3 downto 0);
				F:	out std_logic_vector(6 downto 0)
				);
	end component;
		

	signal	BTN, timer, roundmsb, roundlsb: std_logic_vector(3 downto 0);
				linha, coluna: std_logic_vector(2 downto 0);
				linha7seg, coluna7seg, timer7seg, roundmsb7seg, roundlsb7seg: std_logic_vector(6 downto 0);
				
	begin
		
		display2_01:	decod7seg port map ('0' & coluna, coluna7seg);
		display2_10:	decod7seg port map (roundlsb, roundlsb7seg);
		display3_01:	decod7seg port map ('0' & linha, linha7seg);
		display3_10:	decod7seg port map (roundmsb, roundmsb7seg);
		display4:	decod7seg port map (timer, timer7seg);
		
		--multiplexadores dos HEX(5 downto 0)
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