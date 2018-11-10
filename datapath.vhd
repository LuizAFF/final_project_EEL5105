library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity datapath is
	port	(
			R: in std_logic_vector(1 downto 0);
			E: in std_logic_vector(4 downto 0);
			SEL: in std_logic_vector(1 downto 0);
			clock: in std_logic;
			sw_error, end_game, end_time, win0, win1: out std_logic
			);
end datapath;

architecture bhv of datapath is

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
				reset, clock, Sel: in std_logic;
				clock_05hz, clock_1hz, clock_2hz, clock_4hz, output: out std_logic
				);
	end component;
	
	
	component decod7seg is
		port	(
				C: in std_logic_vector(3 downto 0);
				F:	out std_logic_vector(6 downto 0)
				);
	end component;
	
	component multiplexer is
		port	(
				a, b, c, d: in std_logic; 
				Sel : in std_logic_vector(1 downto 0);
				Output : out std_logic
				);
	end component;
	
	begin
	
	
	
end bhv;
	