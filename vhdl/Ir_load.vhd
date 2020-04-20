library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Ir_load is
 Port ( 
     stage: in std_logic_vector(1 downto 0);
     irload: out std_logic
 );
end Ir_load;

architecture ir_load_arch of ir_load is

signal irload_t: std_logic;

begin

irload <= irload_t;
  process(stage)-- this only changes regsel value to a non-zero during stage 2
    begin
      case stage is
        when "00" => --0->1
          irload_t <='1';
        when others =>
          irload_t <= '0';
      end case;
  end process;
end ir_load_arch;
