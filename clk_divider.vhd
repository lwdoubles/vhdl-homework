LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY clk_divider IS
PORT(clk,rst:IN std_logic;
	  CLOCK:OUT std_logic);
END clk_divider;
ARCHITECTURE behav OF clk_divider IS
SIGNAL count :INTEGER RANGE 0 TO 49999999;
BEGIN
	PROCESS(clk)
	BEGIN
	IF(clk'EVENT and clk = '1')THEN
		IF(count = 4999 or rst = '0')THEN  --reset timming counting
			count<=0;
		ELSE count<=count+1;
		END IF;
		IF(count<=2499)THEN   --CLOCK divider
			CLOCK<='1';
		ELSE CLOCK<='0';
		END IF;
	END IF;
	END PROCESS;
END behav;