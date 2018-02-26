LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE WORK.cpu_lib.ALL;

entity ram_model is
	port(	input_data:in bit16;
			sel:in reg_type;
	     		reg_wr:in std_logic;
	     		reg_rd:in std_logic;
			en:in std_logic;
			clk:in std_logic;
			qout: out bit16);
			
end ram_model;

architecture rtl of ram_model is
	type ram_type is array(0 to 7) of bit16;
	signal temp_data:bit16;
begin
	process(clk,sel)
		variable ramdata:ram_type;
	begin
		if clk'event and clk = '1' then 
		  ramdata(conv_integer(sel)) := input_data;
		end if;
		temp_data <= ramdata(conv_integer(sel)) after 1 ns;
	end process;
	
	process(temp_data1,temp_data2,reg_rd)
	begin
		if en = '1' then
			qout <= temp_data after 1 ns;
		end if;
	end process;
	
end rtl;
		
		
