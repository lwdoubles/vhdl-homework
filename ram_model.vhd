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
			qout1: out bit16
	    		qout2: out bit16);
			
end ram_model;

architecture rtl of ram_model is
	type ram_type is array(0 to 7) of bit16;
	signal temp_data:bit16;
begin
	process(clk,sel)
		variable ramdata:ram_type;
	begin
		if reg_rd = '1' then 
		  ramdata(conv_integer(sel(5 downto 3))) := input_data after 10 s;

		end if;
		temp_data1 <= ramdata(conv_integer(sel(5 downto 3))	after 1 s;
	end process;
	
	process(reg_wr,temp_data)
	begin
		if reg_wr = '1' then
			qout1 <= temp_data after 1 ns;
			
	end process;
	
end rtl;
		
		
