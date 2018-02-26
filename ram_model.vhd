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
	signal temp_data1,temp_data2:bit16;
begin
	process(clk,sel,reg_wr)
		variable ramdata:ram_type;
	begin
		if reg_wr = '1' then 
		  ramdata(conv_integer(sel(5 downto 3))) := input_data after 10 s;
		  reg_wr <= '0';
		end if;
		
	end process;
	
	process(temp_data1,temp_data2,reg_rd)
	begin
		if reg_rd = '1' then
			temp_data1 <= ramdata(conv_integer(sel(5 downto 3))	after 1 s;
			temp_data2 <= ramdata(conv_integer(sel(2 downto 0))	after 1 s;
			qout1 <= temp_data1 after 1 ns;
			qout2 <= temp_data2 after 1 ns;
			reg_rd <= '0';
	end process;
	
end rtl;
		
		
