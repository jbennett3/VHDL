library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity dest_reg is 
  port( 
    op1op2: in std_logic_vector(3 downto 0);
    stage : in std_logic_vector(1 downto 0);
    dwrite: out std_logic
  ); 
end dest_reg;

architecture dest_reg_write of dest_reg is
signal dwrite_t: std_logic:='0';

begin

dwrite<=dwrite_t;
  process(op1op2,stage)-- this only changes dwrites value to a non-zero during stage 2
    begin
    if ((to_integer(unsigned(stage)))=2) then 
    --if (stage = "10") then
      case (op1op2) is
        when "0000"|"0001"|"0010"|"0011"|"0100" => --0->4
          dwrite_t <= '1';
        when "0101" => --5
          dwrite_t <= '0';
        when "0110" => --6
          dwrite_t <= '1';
        when "0111"|"1000"|"1001"|"1010"|"1011" => --7->11
          dwrite_t <= '0';
        when "1100" => --12
          dwrite_t <= '1';      
        when "1101" => --13
          dwrite_t <= '0';
        when "1110" => --14
          dwrite_t <= '1';
        when others => --15
          dwrite_t <= '0';
      end case;   
    else
         dwrite_t <='0';
    end if;
   end process;
end dest_reg_write;

