library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is
   generic(BUS_WIDTH: POSITIVE := 0);
   port	(
			a, b, c, d: in std_logic_vector(BUS_WIDTH-1 downto 0); 
			Sel : in std_logic_vector(1 downto 0);
			Output : out std_logic
			);
end entity;
 
architecture bhv of multiplexer is
begin 
      with Sel select
         Output <= a when "00",
         	   b when "01",
        	   c when "10",
		   d when others; 
end architecture;
