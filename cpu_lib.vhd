library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--package we define 
package cpu_lib is
  subtype bit16 is std_logic_vector(15 downto 0);
  
  type RwType is (R, W);
  type LenType is (Lword, Lhalf, Lbyte);
  
  subtype alu_type is unsigned(4 downto 0);
  constant ALU_NOP : unsigned(4 downto 0) := "00000";
  constant ALU_AND : unsigned(4 downto 0) := "01001";
  constant ALU_OR : unsigned(4 downto 0) := "01010";
  constant ALU_XOR : unsigned(4 downto 0) := "01011";
  constant ALU_ADD : unsigned(4 downto 0) := "01101";
  constant ALU_SUB : unsigned(4 downto 0) := "01110";
  --constant ALU_MUL : unsigned(4 downto 0) := "00000";
  --constant ALU_MULU : unsigned(4 downto 0) := "00000";
  --right move
  constant ALU_SHL : unsigned(4 downto 0) := "11010";
  constant ALU_SHR : unsigned(4 downto 0) := "11011";
  --constant ALU_SLL : unsigned(4 downto 0) := "00000";
  constant ALU_EQ : unsigned(4 downto 0) := "10110";
  constant ALU_NE : unsigned(4 downto 0) := "10010";
  constant ALU_LT : unsigned(4 downto 0) := "10001";
  constant ALU_LTE : unsigned(4 downto 0) := "11001";
  --constant ALU_GTZ : unsigned(4 downto 0) := "00000";
  --constant ALU_LEZ : unsigned(4 downto 0) := "00000";
  --constant ALU_GEZ : unsigned(4 downto 0) := "00000";
  end cpu_lib;