LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
ENTITY seg2 IS
PORT(clk,rst,en:IN std_logic;
	  idis_data:IN std_logic_vector(15 DOWNTO 0);
	  ds_stcp,ds_shcp,ds_data:OUT std_logic);
END seg2;
ARCHITECTURE behav OF seg2 IS
SIGNAL seg_num: std_logic_vector(3 DOWNTO 0);
SIGNAL seg_duan,seg_wei,count:std_logic_vector(7 DOWNTO 0);
SIGNAL ds_stcpr,ds_shcpr,ds_datar,clk_div_2:std_logic;
BEGIN
	PROCESS(clk,en)  --time div PROCESS
	BEGIN
	IF(en='0')THEN
		clk_div_2<='0';
	ELSIF(rising_edge(clk))THEN
		clk_div_2<=NOT clk_div_2;
	END IF;
	END PROCESS;

	PROCESS(clk_div_2,rst) --counting PROCESS
	BEGIN
	IF(clk_div_2'EVENT and clk_div_2 = '1')THEN
		IF(rst='0' or count="11111111")THEN
			count<=(OTHERS=>'0');
		ELSE
			count <=count + 1;
		END IF;
	END IF;
	END PROCESS;
	
	PROCESS(count)
	BEGIN
	CASE count(7 DOWNTO 6) IS
		WHEN "00"=>seg_num <= idis_data(3 DOWNTO 0); 
		WHEN "01"=>seg_num <= idis_data(7 DOWNTO 4);
		WHEN "10"=>seg_num <= idis_data(11 DOWNTO 8);
		WHEN "11"=>seg_num <= idis_data(15 DOWNTO 12);
	END CASE;
	
	CASE seg_num IS
		WHEN x"0"=>seg_duan <= x"c0"; 
		WHEN x"1"=>seg_duan <= x"f9"; 
		WHEN x"2"=>seg_duan <= x"a4"; 
		WHEN x"3"=>seg_duan <= x"b0";
		WHEN x"4"=>seg_duan <= x"99";
		WHEN x"5"=>seg_duan <= x"92";
		WHEN x"6"=>seg_duan <= x"82";
		WHEN x"7"=>seg_duan <= x"F8";
		WHEN x"8"=>seg_duan <= x"80";
		WHEN x"9"=>seg_duan <= x"90";
		WHEN x"a"=>seg_duan <= x"88";
		WHEN x"b"=>seg_duan <= x"83";
		WHEN x"c"=>seg_duan <= x"c6";
		WHEN x"d"=>seg_duan <= x"a1";
		WHEN x"e"=>seg_duan <= x"86";
		WHEN x"f"=>seg_duan <= x"8e";
		WHEN OTHERS=>seg_duan <=NULL;
	END CASE;
					
	CASE count(7 DOWNTO 6) IS
		WHEN "00"=> seg_wei <= "11111110";
		WHEN "01"=> seg_wei <= "11111101";
		WHEN "10"=> seg_wei <= "11111011";
		WHEN "11"=> seg_wei <= "11110111";
		WHEN OTHERS=> seg_wei <= "11111111";
	END CASE;
	END PROCESS;
	
	PROCESS(clk_div_2,rst)
	BEGIN
	IF(clk_div_2'EVENT and clk_div_2 = '1')THEN
		IF(rst='0')THEN
			ds_shcpr<='0';
		ELSIF((count>x"02" and count<=x"22") or (count>x"24" and count<=x"44") or
				(count>x"46" and count<=x"66") or (count>x"68" and count<=x"88") or
				(count>x"90" and count<=x"b0") or (count>x"b2" and count<=x"d2") or
				(count>x"d4" and count<=x"f4") )THEN
			ds_shcpr<=NOT ds_shcpr;
		ELSE
			ds_shcpr<='0';
		END IF;
	END IF;
	END PROCESS;

	PROCESS(clk_div_2, rst)
	BEGIN
	IF(clk_div_2'EVENT and clk_div_2 = '1')THEN
		IF(rst='0')THEN
			ds_datar<='0';
		ELSE
			CASE(count) IS
				WHEN x"02"|x"46"|x"90"|x"d4"=>ds_datar <= seg_duan(7);
				WHEN x"04"|x"48"|x"92"|x"d6"=>ds_datar <= seg_duan(6);
				WHEN x"06"|x"4a"|x"94"|x"d8"=>ds_datar <= seg_duan(5);
				WHEN x"08"|x"4c"|x"96"|x"da"=>ds_datar <= seg_duan(4);
				WHEN x"0a"|x"4e"|x"98"|x"dc"=>ds_datar <= seg_duan(3);
				WHEN x"0c"|x"50"|x"9a"|x"de"=>ds_datar <= seg_duan(2);
				WHEN x"0e"|x"52"|x"9c"|x"e0"=>ds_datar <= seg_duan(1);
				WHEN x"10"|x"54"|x"9e"|x"e2"=>ds_datar <= seg_duan(0);
				WHEN x"12"|x"56"|x"a0"|x"e4"=>ds_datar <= seg_wei(0);
				WHEN x"14"|x"58"|x"a2"|x"e6"=>ds_datar <= seg_wei(1);
				WHEN x"16"|x"5a"|x"a4"|x"e8"=>ds_datar <= seg_wei(2);
				WHEN x"18"|x"5c"|x"a6"|x"ea"=>ds_datar <= seg_wei(3);
				WHEN x"1a"|x"5e"|x"a8"|x"ec"=>ds_datar <= seg_wei(4);
				WHEN x"1c"|x"60"|x"aa"|x"ee"=>ds_datar <= seg_wei(5);
				WHEN x"1e"|x"62"|x"ac"|x"f0"=>ds_datar <= seg_wei(6);
				WHEN x"20"|x"64"|x"ae"|x"f2"=>ds_datar <= seg_wei(7);
			
				WHEN x"24"|x"68"|x"b2"=>ds_datar <='1';
				WHEN x"26"|x"6a"|x"b4"=>ds_datar <='1';
				WHEN x"28"|x"6c"|x"b6"=>ds_datar <='1';
				WHEN x"2a"|x"6e"|x"b8"=>ds_datar <='1';
				WHEN x"2c"|x"70"|x"ba"=>ds_datar <='1';
				WHEN x"2e"|x"72"|x"bc"=>ds_datar <='1';
				WHEN x"30"|x"74"|x"be"=>ds_datar <='1';
				WHEN x"32"|x"76"|x"c0"=>ds_datar <='1';
				WHEN x"34"|x"78"|x"c2"=>ds_datar <='1';
				WHEN x"36"|x"7a"|x"c4"=>ds_datar <='1';
				WHEN x"38"|x"7c"|x"c6"=>ds_datar <='1';
				WHEN x"3a"|x"7e"|x"c8"=>ds_datar <='1'; 
				WHEN x"3c"|x"80"|x"ca"=>ds_datar <='1';
				WHEN x"3e"|x"82"|x"cc"=>ds_datar <='1';
				WHEN x"40"|x"84"|x"ce"=>ds_datar <='1';
				WHEN x"42"|x"86"|x"d0"=>ds_datar <='1';
				WHEN OTHERS=>ds_datar<='1';
			END CASE;
		END IF;
	END IF;
	END PROCESS;

PROCESS(clk_div_2,rst)
BEGIN
IF(clk_div_2'EVENT and clk_div_2 = '1')THEN
	IF(rst='0')THEN
		ds_stcpr<='0';
	ELSIF((count=x"01") or (count=x"23") or (count=x"45") or (count=x"67") or 
	      (count=x"89") or (count=x"b1") or (count=x"d3"))THEN
		ds_stcpr<='0';
	ELSIF((count=x"22") or (count=x"44") or (count=x"66") or (count=x"88") or 
	      (count=x"b0") or (count=x"d2") or (count=x"f4"))THEN
		ds_stcpr<='1';
	END IF;
END IF;
END PROCESS;

ds_stcp<=ds_stcpr;
ds_shcp<=ds_shcpr;
ds_data<=ds_datar;

END behav;