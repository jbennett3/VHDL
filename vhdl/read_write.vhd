library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity read_write is
  Port ( 
irbit4: in std_logic;
irbit5: in std_logic;
irbit6: in std_logic;
stage:  in std_logic_vector(1 downto 0);
readwrite: out std_logic
);
end read_write;

architecture read_write_arch of read_write is

signal mout: std_logic;
signal readwrite_t: std_logic;

begin
readwrite<= readwrite_t;
process(irbit4,irbit5,irbit6,stage)
  begin
    mout <= irbit4 and irbit6 and (not irbit5);
    case stage is
      when "10" =>
        readwrite_t <= mout;
      when others =>
        readwrite_t <= '0';
    end case;
end process;
end read_write_arch;
