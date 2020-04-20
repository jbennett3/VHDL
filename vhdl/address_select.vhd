library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity address_select is
  Port ( 
    stage: in std_logic_vector(1 downto 0); 
    op1op2: in std_logic_vector(3 downto 0);
    addrsel: out std_logic_vector(1 downto 0)
  );
end address_select;

architecture Behavioral of address_select is

signal addrsel_t: std_logic_vector(3 downto 0):(others=>'0');

begin
  process(op1op2,stage)
    begin
      
  end process;
end Behavioral;
