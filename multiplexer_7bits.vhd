library ieee;
use ieee.std_logic_1164.all;

entity multiplexer_7bits is
   port	(
			a, b, c, d: in std_logic_vector(6 downto 0); 
			Sel : in std_logic_vector(1 downto 0);
			Output : out std_logic_vector(6 downto 0)
			);
end entity multiplexer_7bits;
 
architecture bhv of multiplexer_7bits is
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