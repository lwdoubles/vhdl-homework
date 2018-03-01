library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ps2_combine is
port(ps2k_dec : in std_logic_vector(7 downto 0);
	  rst_n : in std_logic;
	  ps2k_comb : out std_logic_vector(15 downto 0));
end ps2_combine;

architecture behav of ps2_combine is
begin
  process(ps2k_dec,rst_n)
  begin
    if rst_n = '0' then
		ps2k_comb <= "0001010010011111";
	 else ps2k_comb <= "00000000"& ps2k_dec;
	   
	end if;
  end process;
end behav;