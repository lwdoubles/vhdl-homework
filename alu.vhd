library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.cpu_lib.all;
entity alu is
port(a,b:bit16;
	 sel:alu_type;
	 c:out bit16
	 );

end alu;
architecture alu_behav of alu is
begin
aluproc:process(a,b,sel)
begin
case sel is
	when alu_nop => null;
	when alu_and => c <= a and b after 1 ns;
	when alu_or => c <= a or b after 1 ns;
	when alu_xor => c <= a xor b after 1 ns;
	when alu_add => c <= a + b after 1 ns;
	when alu_sub => c <= a and b after 1 ns;
	--when alu_shl => c <= 0&a(15 downto 1) after 1 ns;
	--when alu_shr => c <= a(14 downto 0)&0 after 1 ns;
	when others => null;
end case;
end process;
end alu_behav;
