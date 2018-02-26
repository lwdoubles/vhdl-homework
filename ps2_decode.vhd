library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ps2_decode is
	port(clk: in std_logic;
		  rst_n: in std_logic;
		  ps2k_clk: in std_logic;
		  ps2k_data: in std_logic;
		  ps2k_dec: out std_logic_vector(15 downto 0)
		  );
end ps2_decode;

architecture decoding of ps2_decode is
	signal ps2k_clk_r: std_logic_vector (2 downto 0); 
	signal neg_ps2k_clk: std_logic; 
	signal temp_data: std_logic_vector (7 downto 0);  
	signal num: std_logic_vector (3 downto 0);  
	signal ps2_byte_r: std_logic_vector (7 downto 0); 
	signal output_counter: std_logic_vector (2 downto 0);
	signal break_code_flag: std_logic;
	signal temp_decode: std_logic_vector (4 downto 0);
	signal temp_ps2k_dec: std_logic_vector(15 downto 0);
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
			if(ps2_byte_r = x"45") then----0
				temp_decode <= "0000";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"16") then----1
				temp_decode <= "0001";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"1e") then----2
				temp_decode <= "0010";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"26") then----3
				temp_decode <= "0011";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"25") then----4
				temp_decode <= "0100";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"2e") then----5
				temp_decode <= "0101";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"36") then----6
				temp_decode <= "0110";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"3d") then----7
				temp_decode <= "0111";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"3e") then----8
				temp_decode <= "1000";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"46") then----9
				temp_decode <= "1001";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"1c") then----10(a)
				temp_decode <= "1010";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"32") then----11(b)
				temp_decode <= "1011";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"21") then----12(c)
				temp_decode <= "1100";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"23") then----13(d)
				temp_decode <= "1101";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"24") then----14(e)
				temp_decode <= "1110";
				output_counter <= output_counter + 1;
			elsif(ps2_byte_r = x"2b") then----15(f)
				temp_decode <= "1111";
				output_counter <= output_counter + 1;
			else null;
			end if;
		end if;
  end process;
-------------------decoded key value loading
  process(temp_decode)
   begin
	  if (output_counter = "001") then
	    temp_ps2k_dec(15 downto 12) <= temp_decode;
	  elsif (output_counter = "010") then
	    temp_ps2k_dec(11 downto 8) <= temp_decode;
	  elsif (output_counter = "011") then
	    temp_ps2k_dec(7 downto 4) <= temp_decode;
	  elsif (output_counter = "100") then
	    temp_ps2k_dec(3 downto 0) <= temp_decode;
		 output_counter <= "111";
	  else output_counter <= "000";
	  end if;
  end process;
 -------------------output decoded key value
  process(output_counter)
	begin
	  if (output_counter = "111")then
	    ps2k_dec <= temp_ps2k_dec;
		 output_counter <= "000";
		else ps2k_dec <= x"0000";
	  end if;
  end process;
end decoding;