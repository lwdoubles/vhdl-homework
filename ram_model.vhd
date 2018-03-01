LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE WORK.cpu_lib.ALL;

entity ram_model is
	port(	input_data:in bit8;
			sel:in reg_type;
	     		reg_wr:in std_logic;
	     		reg_rd:in std_logic;
			en:in std_logic;
			clk:in std_logic;
			qout: out bit8);
			
end ram_model;

architecture rtl of ram_model is
	type ram_type is array(0 to 3) of bit8;
	signal temp_data:bit8;
begin
	process(input_data)
		variable ramdata:ram_type;
	begin
		ramdata(conv_integer(sel)) := input_data;	
		temp_data <= ramdata(conv_integer(sel)) after 1 ns;
	end process;
	
	process(temp_data)
	begin
		if en = '1' then
			qout <= temp_data after 1 ns;
		end if;
	end process;
	
end rtl;
		
		
