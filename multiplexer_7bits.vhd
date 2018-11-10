library ieee;
use ieee.std_logic_1164.all;

entity multiplexer_7bits is
   port	(
			a, b, c, d: in std_logic_vector(6 downto 0); 
			Sel : in std_logic_vector(1 downto 0);
			Output : out std_logic_vector(6 downto 0)
			);
end entity;
 
architecture bhv of multiplexer_7bits is
begin
      with Sel select
         Output <= a when "00",
         	   b when "01",
        	   c when "10",
          	   d when others; 
end architecture;
