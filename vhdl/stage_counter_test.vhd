----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2018 07:00:51 AM
-- Design Name: 
-- Module Name: stage_counter_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stage_counter_test is
--  Port ( );
end stage_counter_test;

architecture Behavioral of stage_counter_test is


--component stage_counter
--  port(
--   clk: in std_logic;
--   rst: in std_logic;
--   stage: out std_logic_vector(1 downto 0)
--   );
--   end component;
signal clk,rst: std_logic;
signal stage: std_logic_vector(1 downto 0);
begin
  dut:entity work.stage_counter port map(clk=>clk,rst=>rst,stage=>stage);
  --clock_process:process
  process
    begin
      clk<='0';
      wait for 10ns;
      clk<='1';
      wait for 10ns;
end process;

end Behavioral;
