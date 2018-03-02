library ieee;  
use ieee.std_logic_1164.all; 
USE WORK.cpu_lib.ALL;
  
entity decoder_2to4 is 
	port(sel: in  reg_type;   
		  sel00:  out std_logic;   
		  sel01:  out std_logic;   
		  sel02:  out std_logic;   
		  sel03:  out std_logic   );    
	end decoder_2to4;   
architecture behav of decoder_2to4 is 
begin  
	process(sel)  
	begin     
	case sel is 
	when "00"=>sel00 <= '1';     
				  sel01 <= '0';     
				  sel02 <= '0';     
				  sel03 <= '0';   
	when "01"=>sel00 <= '0';     
				  sel01 <= '1';     
				  sel02 <= '0';     
				  sel03 <= '0';    
	when "10"=>sel00 <= '0';     
				  sel01 <= '0';     
				  sel02 <= '1';     
				  sel03 <= '0';    
	when "11"=>sel00 <= '0';     
				  sel01 <= '0';     
				  sel02 <= '0';     
				  sel03 <= '1';
	when others=> null;
	end case;
	end process;
end behav;