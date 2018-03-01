library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ps2_combine is
port(ps2k_dec : in std_logic_vector(3 downto 0);
	  rst_n : in std_logic;
	  ps2k_comb : out std_logic_vector(15 downto 0));
end ps2_combine;

architecture behav of ps2_combine is
signal counter : std_logic_vector (1 downto 0);
signal ps2k_comb_temp : std_logic_vector(15 downto 0);
signal full_flag : std_logic;
begin
  process(ps2k_dec,rst_n)
  begin
    if rst_n = '0' then
	   counter <= "00";
		full_flag <= '0';
		ps2k_comb <= "0001010010011111";
	 else counter <= counter +1;
	   case counter is 
		  when "00" => ps2k_comb_temp(15 downto 12)<= ps2k_dec;
		  when "01" => ps2k_comb_temp(11 downto 8)<= ps2k_dec;
		  when "10" => ps2k_comb_temp(7 downto 4)<= ps2k_dec;
		  when "11" => ps2k_comb_temp(3 downto 0)<= ps2k_dec;
		               full_flag <= '1';
		  when others => null;
		end case;
	   if (full_flag = '1')then
		  full_flag <='0';
		  ps2k_comb <= ps2k_comb_temp;
		end if;
	end if;
  end process;
end behav;