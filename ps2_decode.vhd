library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ps2_decode is
	port(clk: in std_logic;
		  rst_n: in std_logic;
		  ps2k_clk: in std_logic;
		  ps2k_data: in std_logic;
		  ps2k_out: out std_logic_vector(7 downto 0)
		  );
end ps2_decode;

architecture decoding of ps2_decode is
	signal ps2k_clk_r: std_logic_vector (2 downto 0); 
	signal neg_ps2k_clk: std_logic; 
	signal temp_data: std_logic_vector (7 downto 0);  
	signal num: std_logic_vector (3 downto 0);  
	signal ps2_byte_r: std_logic_vector (7 downto 0); 
	signal break_code_flag: std_logic;
begin 
---------------clock deling process  
  process(clk,rst_n)    
    begin 
      if (rst_n = '0') then   
        ps2k_clk_r <= "000";  
      elsif (clk'event AND clk = '1') then    
        ps2k_clk_r <= ps2k_clk_r(1 downto 0) & ps2k_clk;  
      end if; 
  end process;  
----------------------  
  neg_ps2k_clk <= '1' when ps2k_clk_r(2 downto 1) = "10" else   
      '0';  
----------------------key value reading process  
  process(clk,rst_n)    
    begin 
      if (rst_n = '0') then   
        num <= x"0";  
        temp_data <= x"00"; 
      elsif (clk'event AND clk = '1') then    
        if (neg_ps2k_clk = '1') then  
          num <= num+1; 
          case num is           
          when x"1" => temp_data(0) <= ps2k_data;  
          when x"2" => temp_data(1) <= ps2k_data;  
          when x"3" => temp_data(2) <= ps2k_data;  
          when x"4" => temp_data(3) <= ps2k_data;  
          when x"5" => temp_data(4) <= ps2k_data;  
          when x"6" => temp_data(5) <= ps2k_data;  
          when x"7" => temp_data(6) <= ps2k_data;  
          when x"8" => temp_data(7) <= ps2k_data;      
		
          when others => null;  
        end case; 	
      end if; 
       
      if (num = x"b") then  
        num <= x"0";  
      end if; 
    end if; 
  end process;  
-------------------key value reset enable        
  process(clk,rst_n)   
	begin 
	  if (rst_n = '0') then   
		  ps2_byte_r <= x"00";  
	  elsif (clk'event AND clk = '1') then    
		 if (num = x"b") then 
			  ps2_byte_r <= temp_data;  
		 end if; 
	  end if; 
	end process; 
-------------------key value translate
  process(ps2_byte_r)
	begin
		if (ps2_byte_r = x"f0") then
			break_code_flag <= '1';
		else break_code_flag <= '0';
		end if;

		if (break_code_flag = '1') then
			break_code_flag <= '0';
		else 
			ps2k_out <= ps2_byte_r;
		end if;
  end process;
end decoding;