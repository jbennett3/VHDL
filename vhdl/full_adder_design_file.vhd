library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

LIBRARY adk;
USE adk.all;

entity full_adder_design_file is
  Port ( 
  FNum1: in std_logic;  
  FNum2: in std_logic;
  Fcarry_in: in std_logic;
  Fsum: out std_logic;
  Fcarry_out: out std_logic
);
end full_adder_design_file;

architecture Behavioral of full_adder_design_file is
signal temp_sum, temp_carry, temp_carry2: std_logic;

component half_adder
  Port ( 
  HNum1: in std_logic;  
  HNum2: in std_logic;
  Hsum: out std_logic;
  Hcarry: out std_logic
  );    
end component;

component or_adder
  Port ( 
  Num1: in std_logic;
  Num2: in std_logic;
  sum: out std_logic  
  );
end component;

begin

h0: half_adder port map(HNum1=>FNum1, HNum2=>FNum2, Hsum=>temp_sum, Hcarry=>temp_carry);
h1: half_adder port map(HNum1=>temp_sum, HNum2=>Fcarry_in, Hsum=>Fsum, Hcarry=>temp_carry2);
a0: or_adder port map(Num1=>temp_carry, Num2=>temp_carry2, sum=>Fcarry_out);

end Behavioral;
