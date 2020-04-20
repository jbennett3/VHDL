
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity stage_counter is
  Port(
    clk: in std_logic;
    rst: in std_logic;
    stage: out std_logic_vector(1 downto 0)
  );
end stage_counter;

architecture stage_arch of stage_counter is

signal stage_next: std_logic_vector(1 downto 0);

begin

stage<=stage_next;
process(stage_next,clk, rst)
  begin
    if(clk'event and clk='1') then
      case stage_next is
        when "00"=>
          stage_next <= "01";
        when "01"=>
          stage_next <= "10";
        when "10"=>
          stage_next<= "00";
        when others =>
          stage_next<="00";
      end case;
    end if;
    
end process;
end stage_arch;


