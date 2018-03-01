LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.cpu_lib.ALL;

entity outreg is
port(reg_in:in bit8;
	  reg_clk:in std_logic;
	  reg_out:out bit8;
	  outregwr:in std_logic);
	  
end outreg;

architecture rtl of outreg is
begin
	regproc:process(reg_clk)
	begin
	if reg_clk'event and reg_clk = '1' then
		if outregwr = '1' then 
			reg_out <= reg_in;
		end if;
	end if;
	end process;
end rtl;