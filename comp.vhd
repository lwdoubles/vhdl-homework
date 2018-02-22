library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.cpu_lib.all;
entity comp is
port(a,b:bit16;
	 sel:alu_type;
	 c_comp:out std_logic
	 );
end comp;	 
architecture comp_behav of comp is
begin
aluproc:process(a,b,sel)
begin
case sel is
	when alu_eq => 
		if a = b then 
			c_comp <= '1' after 1 ns;
		else
			c_comp <= '0' after 1 ns;
		end if;
	
	when alu_ne => 
		if a /= b then 
			c_comp <= '1' after 1 ns;
		else
			c_comp <= '0' after 1 ns;
		end if;
			
	when alu_lt => 
		if a < b then 
			c_comp <= '1' after 1 ns;
		else
			c_comp <= '0' after 1 ns;
		end if;
			
	when alu_lte => 
		if a <= b then 
			c_comp <= '1' after 1 ns;
		else
			c_comp <= '0' after 1 ns;
		end if;
	when others => null;
end case;
end process;
end comp_behav;