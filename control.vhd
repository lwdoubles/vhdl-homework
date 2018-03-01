LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.cpu_lib.ALL;

entity control is
port(clock:in std_logic;
	 reset:in std_logic;
	 --keyboard input
	 instrReg:in bit8;
	 
	 
	 compout:in std_logic;
	 ready:in std_logic;
	 progCntrWr:out std_logic;
	 addrRegWr:out std_logic;
	 addrRegRd:out std_logic;
	 outRegWr:out std_logic;
	 outRegRd:out std_logic;
	 --shiftSel:out shift_type;
	 aluSel:out alu_type;
	 --compSel:out comp_type;
	 opRegRd:out std_logic;
	 opRegWr:out std_logic;
	 instrWr:out std_logic;
	 regSel:buffer reg_type;
	 outsel:out std_logic;
	 regRd:out std_logic;
	 regWr:out std_logic;
	 rw:out std_logic;
	 vma:out std_logic 
	 );
	 
end control;

architecture rtl of control is
	 signal current_state, next_state:state;
begin
	 nxtstateproc:process(current_state, instrReg, compout, ready)
	 begin
	 
	 --progCntrWr <= '0';
	 --progCntrRd <= '0';
	 addrRegWr <= '0';
	 outRegWr <= '0';
	 outRegRd <= '0';
	 outsel <= '0';
	 --next_state <= execute;
	 --shiftSel <= shiftpass;
	 aluSel <= "0000";
	 --compSel <= eq;
	 opRegRd <= '0';
	 opRegWr <= '0';
	 instrWr <= '0';
	 --if regSel = "XXX" then	
		--regSel <= "000";
	 --end if;
	 regRd <= '0';
	 regWr <= '0';
	 rw <= '0';
	 vma <= '0';
	 case current_state is
		when execute =>
			case instrReg(7 downto 4) is
				--null op
				when "0000" =>
					next_state <= incPc;
				--load op
				when "0001" =>
					regWr <= '1';
					next_state <= load1;
				
				--add op	
				when "0010" =>
					next_state <= add1;
					
				when "0011" =>
					next_state <= sub1;
				
				when others =>
					next_state <= incPc;
			end case;
		 	
		when load1 =>
			regRd <= '0';
			regWr <= '1';
			OpRegWr <= '1';
			regSel <= instrReg(1 downto 0);	
			next_state <= load2;
			
		when load2 =>
			regRd <= '0';
			regWr <= '1';
			OpRegWr <= '1';
			regSel <= instrReg(1 downto 0);	
			next_state <= move1;
							
		when move1 =>
			regRd <= '1';
			regWr <= '0';
			next_state <= move2;
			
		when move2 =>
			regRd <= '1';
			regWr <= '0';
			next_state <= incPc;
			
		when move3 =>
			regRd <= '1';
			regWr <= '0';
			outsel <= '1';
			next_state <= move4;
			
		when move4 =>
			regRd <= '1';
			regWr <= '0';
			outsel <= '1';
			next_state <= move5;
		
		when move5 =>
			outSel <= '0';
			next_state <= incPc;
			
		
						
		when add1 => 
			OpRegWr <= '0';
			aluSel <= alu_add;
			--outSel <= 							
			regRd <= '0';
			regWr <= '1';
			regSel <= instrReg(1 downto 0);	
			next_state <= add2;
			
		when add2 => 
			OpRegWr <= '0';
			aluSel <= alu_add;							
			regRd <= '0';
			regWr <= '1';
			regSel <= instrReg(1 downto 0);	
			next_state <= move3;
			
			
		when sub1 => 
			OpRegWr <= '0';
			aluSel <= alu_add;							
			regRd <= '0';
			regWr <= '1';
			regSel <= instrReg(1 downto 0);	
			next_state <= sub2;
			
		when sub2 => 
			OpRegWr <= '0';
			aluSel <= alu_add;							
			regRd <= '0';
			regWr <= '1';
			regSel <= instrReg(1 downto 0);	
			next_state <= move1;
				
		when incPc =>
			regSel <= regSel;
			outsel <= '0';
			
	end case;
	end process;
	
	
	controlproc:process(reset,next_state,clock)
	begin
		if reset = '0' then
			current_state <= execute;
		elsif clock'event and clock = '1' then 
			current_state <= next_state;
		end if;
	end process;
		
end rtl;  
			
			
				
	
			
	   
	   
		
	
		
	
	 
