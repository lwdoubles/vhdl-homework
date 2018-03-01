library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--package we define 
package cpu_lib is
  subtype bit8 is std_logic_vector(7 downto 0);
  subtype reg_type is std_logic_vector(2 downto 0);
  
  type RwType is (R, W);
  type LenType is (Lword, Lhalf, Lbyte);
  type comp_type is (eq, neq, gt, gte, lt, lte);
  type state is (load1, load2, load3, add1, incPc,execute);
  
  subtype alu_type is unsigned(3 downto 0);
  constant ALU_NOP : unsigned(3 downto 0) := "0000";
  constant ALU_AND : unsigned(3 downto 0) := "0001";
  constant ALU_OR : unsigned(3 downto 0) := "0010";
  constant ALU_XOR : unsigned(3 downto 0) := "0100";
  constant ALU_ADD : unsigned(3 downto 0) := "0101";
  constant ALU_SUB : unsigned(3 downto 0) := "0110";
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
