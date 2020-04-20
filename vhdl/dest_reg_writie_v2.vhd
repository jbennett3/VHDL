library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dest_reg_writie_v2 is
  port( 
    op1: in std_logic_vector(1 downto 0);
    op2: in std_logic_vector(1 downto 0);
    stage : in std_logic_vector(1 downto 0);
    dwrite: out std_logic
  ); 
end dest_reg_writie_v2;

architecture Behavioral of dest_reg_writie_v2 is
signal dwrite_t: std_logic:='0';
begin


end Behavioral;
