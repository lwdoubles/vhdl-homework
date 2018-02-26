LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.cpu_lib.ALL;

entity control is
port(clock:in std_logic;
	 reset:in std_logic;
	 --keyboard input
	 instrReg:in bit16;
	 
	 
	 compout:in std_logic;
	 ready:in std_logic;
	 progCntrWr:out std_logic;
	 addrRegWr:out std_logic;
	 addrRegRd:out std_logic;
	 outRegWr:out std_logic;
	 outRegRd:out std_logic;
	 shiftSel:out shift_type;
	 aluSel:out alu_type;
	 compSel:out comp_type;
	 opRedRd:out std_logic;
	 opRegWr:out std_logic;
	 instrWr:out std_logic;
	 regSel:out reg_type;
	 regRd:out std_logic;
	 regWr:out std_logic;
	 rw:out std_logic;
	 vma:out std_logic 
	 );
	 
end control;

architecture rtl of controller is
	 signal current_state, next_state:state;
begin
	 nxtstateproc:process(current_state, instrReg, compout, ready)
	 begin
	 
	 progCntrWr <= '0';
	 progCntrRd <= '0';
	 addrRegWr <= '0';
	 outRegWr <= '0';
	 outRegRd <= '0';
	 shiftSel <= shiftpass;
	 aluSel <= alupass;
	 compSel <= eq;
	 opRegRd <= '0';
	 opRegWr <= '0';
	 instrWr <= '0';
	 regSel <= "000";
	 regRd <= '0';
	 regWr <= '0';
	 rw <= '0';
	 vma <= '0';
	 case current_state is
		when execute =>
			case instrReg(15 downto 11) is
				--null op
				when "00000" =>
					next_state <= incPc;
				--load op
				when "00001" =8y877>
					regWr <= '1';
					next_state <= load1;
				
				--add op	
				when "00010" =>
					next_state <= add1;
				
				when others =>
					next_state <= incPc;
			end case;
		
			
				
	 	
		when load1 =>
			regWr <= '1';
			OpRegWr <= '1';
			regSel <= instrReg(2 downto 0);	
			next_state <= load2;
			
		when load2 =>
			OpRegWr <= '0';
			regWr <= '1';
			next_state <= load3;
			
		when load3 =>
			OpRegWr <= '0';
			regWr <= '1';
			regSel <= instrReg(5 downto 3);
			next_state <= incPc;
		
			
		when add1 => 
			aluSel <= alu_add;							
			regSel <= instrReg (5 downto 3);
			regRd <= '1';
			next_state <= incPc;
				
		when incPc =>
			NULL;
	end case;
	end process;
	
	
	controlproc:process(reset,next_state)
	begin
		if reset = '1' then
			current_state <= execute;
		else
			current_state <= next_state;
		end if;
	end process;
		
end rtl;  
			
			
				
	
			
	   
	   
		
	
		
	
	 
