library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
  Port ( 
  HNum1: in std_logic;  
  HNum2: in std_logic;
  Hsum: out std_logic;
  Hcarry: out std_logic
);
end half_adder;

architecture Behavioral of half_adder is

begin
Hsum <= HNum1 xor HNum2;
Hcarry <= HNum1 and HNum2;

end Behavioral;
