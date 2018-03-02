LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.cpu_lib.ALL;

entity reg is
	port(input_data: in bit8;
		 clk,rst,reg_wr,reg_rd,sel:in std_logic;
		 qout:out bit8);
		 
end reg;

architecture rtl of reg is
signal temp_data : bit8;
begin
process(clk,rst)
	begin
		if (rst = '0')then 
		temp_data <= "00000000";
		elsif (clk'event and clk = '1')then
			if (sel = '1' and reg_wr = '1') then
				temp_data <= input_data;			
			end if;
		end if;
	end process;
	
	process(clk,rst)
	begin
		if (rst = '0')then
		qout <= "00000000";
		elsif (clk'event and clk = '1')then
			if (sel = '1' and reg_rd = '1') then
				qout <= temp_data;	
			end if;
		end if;
	end process;
	
end rtl;