library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.cpu_lib.all;
entity temp_alu is
port(a,b:in bit16;
	 sel:in alu_type;
	 c:out bit16;
	 Flag :out std_logic_vector(3 downto 0));
end temp_alu;
architecture alu_behav of temp_alu is
begin
aluproc:process(a,b,sel)
variable ALUResult,opR,opS : std_logic_vector(16 downto 0);	 --17 bit to save C bit
variable cx,tempC,tempZ,tempV,tempS : std_logic; 	
begin
	opR := '0'&a;--load data(later will change it by loading method)
	opS := '0'&b;
	----------Calculating Operation----------
	case sel is
		when alu_nop => null;
		when alu_and => ALUResult := opR and opS;
		when alu_or =>  ALUResult := opR or  opS;
		when alu_xor => ALUResult := opR xor opS;
		when alu_add => ALUResult := opR  +  opS;
		when alu_sub => ALUResult := opR  -  opS;
	   when alu_shl => ALUResult(15 downto 1) := opR(14 downto 0);
							 ALUResult(0) := '0';	cx := opR(15);
	   when alu_shr => ALUResult(14 downto 0) := opR(15 downto 1);
							 ALUResult(15) := '0';	cx := opR(0);
		when others => null;
	end case;
	c <= ALUResult(15 downto 0);
	----------Flag Setting-------------------
	case sel is
		-----Flag C V---------
		when alu_add|alu_sub    	 	=>   tempC := ALUResult(16);			
		when alu_shl|alu_shr     		=>   tempC := cx;	
		when alu_and|alu_or|alu_xor 	=>   tempC := '0'; tempV:= '0'; --zero C and Z for logic ALU
		when others					  		=>   null;						
	end case;	
		-----Flag Z-----------
		if ALUResult = "0000000000000000" then	tempZ := '1';
		else tempZ := '0';	
		end if;	 
		-----Flag S-----------
		tempS := ALUResult(15);
		-----Flag load in-----
		Flag  <= (tempC,tempZ,tempV,tempS);
		--case e_setFlag is
			--when flag_hold	  => (C,Z,V,S)<= tempFLAG; 
			--when flag_update  => C<=tempC;	Z <= tempZ;	V <= tempV;	S <= tempS;
		   --when flag_InnerDB => (C,Z,V,S) <= e_IMM(3 downto 0);
			--when flag_clear	  => C<='0'; Z<='0'; V<='0'; S<='0';
			--when others		  => (C,Z,V,S)<= tempFLAG; 
		--end case;

end process;
end alu_behav;
