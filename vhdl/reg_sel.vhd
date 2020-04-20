library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity reg_sel is 
  port(
    op1op2: in std_logic_vector(3 downto 0);
    stage: in std_logic_vector(1 downto 0);
    regsel: out std_logic_vector(1 downto 0)
  ); 
end reg_sel;

architecture reg_sel_arch of reg_sel is
signal mout: std_logic_vector(1 downto 0);
signal regsel_t: std_logic_vector(1 downto 0);

begin
  regsel<=regsel_t;
  process(op1op2,stage)-- this only changes regsel value to a non-zero during stage 2
    begin
    if((to_integer(unsigned(stage)))=1) then
      case (op1op2) is
        when "0000"|"0001"|"0010"|"0011" => --0->3
          mout <= "11";
        when "0100" => --4
          mout <= "10";
            --when "0101" => --5
              --mout <= "00";
        when "0110" => --6
          mout <= "01";
            --when "0111"|"1000"|"1001"|"1010"|"1011" => --7->11
              --mout <= "00";
        when "1100" => --12
          mout <= "10";      
            --when "1101" |"1110"| "1111" => --13->15
             --mout <= "00";
        when others =>
          mout<="00";
      end case;
    elsif((to_integer(unsigned(stage)))=2) then
      case stage is
        when "00"|"01" => --0->1
          regsel_t <= "00";
        when "10" =>
          regsel_t <= mout;
        when others =>
          regsel_t<=regsel_t;
      end case;
    else
      regsel_t<=regsel_t;
    end if; 
  end process;
end reg_sel_arch;

