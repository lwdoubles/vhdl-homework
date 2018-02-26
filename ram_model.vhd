LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE WORK.cpu_lib.ALL;

entity ram_model is
	port(	input_data:in bit16;
			sel:in reg_type;
			en:in std_logic;
			clk:in std_logic;
			qout:out bit16);
			
end ram_model;

architecture rtl of ram_model is
	type ram_type is array(0 to 7) of bit16;
	signal temp_data:bit16;
begin
	process(clk,sel)
		variable ramdata:ram_type;
	begin
		if clk'event and clk = '1' then 
		  ramdata(conv_integer(sel)) := input_data after 10 s;
		end if;
		temp_data <= ramdata(conv_integer(sel))	after 1 s;
	end process;
	
	process(en,temp_data)
	begin
		if en = '1' then
			q <= temp_data after 1 ns;
		else
			q <= "ZZZZZZZZZZZZZZZZ" after 1 ns;
		end if;
	end process;
	
end rtl;
		
		
