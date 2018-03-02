--used to describe address register or instruction(order) register
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.cpu_lib.ALL;

entity reg is
	port(ain: in bit16;
		 clk:in std_logic;
		 qout:out bit16);
		 
end reg;

architecture rtl of reg is
begin
	regproc:process
	begin
		wait until clk'event and clk = '1';
		q <= ain ;
	end process;
	
end rtl;
