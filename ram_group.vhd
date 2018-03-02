library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
USE WORK.cpu_lib.ALL;
 
entity ram_group is 
	Port( sel:   reg_type;    
	      rst:   in std_logic;   
			reg_wr:in std_logic;
	     	reg_rd:in std_logic;                            
			clk:   in std_logic;    
			input_data:  in  bit8;   
			qout: out bit8                 
			); 
end ram_group;

architecture struct of ram_group is 
-- components  
-- 16 bit Register for register file 
component reg 
	port(input_data: in bit8;
		  clk,rst,reg_wr,reg_rd,sel:in std_logic;
		  qout:out bit8);
end component; 

-- 2 to 4 Decoder  
component  decoder_2to4  
	port(sel: in  reg_type;   
		  sel00:  out std_logic;   
		  sel01:  out std_logic;   
		  sel02:  out std_logic;   
		  sel03:  out std_logic   );    
end component;

signal reg00, reg01, reg02, reg03  :bit8;   
signal sel00 ,sel01 ,sel02 ,sel03  : std_logic;   
begin  
	Areg00: reg port map( rst   =>  rst,   
								 input_data => input_data ,   
								 clk  => clk ,     
								 reg_wr => reg_wr ,  
								 reg_rd => reg_rd ,
								 sel => sel00,
								 qout   =>  reg00   );   
	
   Areg01: reg port map( rst   =>  rst,   
								 input_data => input_data ,   
								 clk  => clk ,     
								 reg_wr => reg_wr ,  
								 reg_rd => reg_rd ,
								 sel => sel01,
								 qout   =>  reg01   ); 
	Areg02: reg port map( rst   =>  rst,   
								 input_data => input_data ,   
								 clk  => clk ,     
								 reg_wr => reg_wr ,  
								 reg_rd => reg_rd ,
								 sel => sel02,
								 qout   =>  reg02   ); 
	Areg03: reg port map( rst   =>  rst,   
								 input_data => input_data ,   
								 clk  => clk ,     
								 reg_wr => reg_wr ,  
								 reg_rd => reg_rd ,
								 sel => sel03,
								 qout   =>  reg03   ); 
								 
-- decoder  
des_decoder: decoder_2to4 port map(sel => sel,  
											  sel00  =>sel00 ,   
											  sel01  =>sel01 ,   
											  sel02  =>sel02 ,   
											  sel03  => sel03    );
end struct;
								 