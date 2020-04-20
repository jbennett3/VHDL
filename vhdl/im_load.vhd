library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity im_load is
  Port ( 
    irbit7: in std_logic;
    stage: in std_logic_vector(1 downto 0);
    imload: out std_logic
  );
end im_load;

architecture Behavioral of im_load is

signal imload_t: std_logic:= '0';

begin
imload<=imload_t;
  process(irbit7,stage)
    begin
      case stage is
        when "01" =>
          imload_t <= irbit7;
        when others =>
          imload_t <= '0';
      end case;
  end process;

end Behavioral;
