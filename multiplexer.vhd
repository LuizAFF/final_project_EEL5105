library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is
   port	(
			a, b, c, d: in std_logic; 
			Sel : in std_logic_vector(1 downto 0);
			Output : out std_logic
			);
end entity multiplexer;
 
architecture bhv of multiplexer is
begin 
   process (a, b, c, d, Sel) is
   begin
      case Sel is
         when "00"  => Output <= a;
         when "01"  => Output <= b;
         when "10"  => Output <= c;
         when "11"  => Output <= d;
      end case;
   end process;
end architecture bhv;