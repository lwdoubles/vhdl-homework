library ieee;
use ieee.std_logic_1164.all;
use work.cpu_lib.all;

entity trireg is
 port(a : in bit8;
	  en : in std_logic;
	  clk : in std_logic;
	  q : out bit8);
	  
end trireg;

architecture rtl of trireg is
 signal val : bit8;
begin
 triregdata:process
 begin
	wait until clk'event and clk = '1';
	val <= a;
 end process;
 
 
 trireg3st:process(en, val)
 begin
  if en = '1' then
    q <= val after 1 ns;
  end if;
  end process;
end rtl;
 
