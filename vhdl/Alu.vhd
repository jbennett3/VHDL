library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Alu is
  generic (b: natural:=7); --b has to be >= 3
  Port(
      operand1: in std_logic_vector(b downto 0);
      operand2: in std_logic_vector(b downto 0);
      operator: in std_logic_vector(1 downto 0);
      result:  out std_logic_vector(b downto 0)
  );
end Alu;

architecture Alu_arch of Alu is
signal add,sub,inc: std_logic_vector(b downto 0):= (others=>'0');
signal add_t,sub_t,one_operand: std_logic_vector(b downto 0):= (others=>'0');
signal temp,t_result: std_logic_vector(b downto 0):= (others=>'0');
signal undesirable: std_logic_vector(b downto 0);
signal overflow_flag, underflow_flag: std_logic;
signal operand2_t: std_logic_vector (b downto 0);

component twos_complement_design
  Port ( 
  -- input values for b-1 bit numbers --
   TNum1: in std_logic_vector(b downto 0);
   TNum2: in std_logic_vector(b downto 0);
   Tsum: out std_logic_vector(b downto 0);
   Tcarry_out: out std_logic
   );
end component;

begin
  one_operand <= std_logic_vector(to_unsigned(1,b+1)); -- 
  -- this is all for add-- 
  p0_0: twos_complement_design port map(TNum1=>operand1,TNum2=>operand2,Tsum=>add_t,Tcarry_out=>undesirable(0));
  p0_1: twos_complement_design port map(TNum1=>add_t,TNum2=>one_operand,Tsum=>add,Tcarry_out=>undesirable(1));--add

  --with subtraction operand2 highest bit is notted eg. operand2=1111 operand2_t=0111 since subtracting a negative is addition
  operand2_t <= (not operand2(7)) & operand2(6 downto 0);
  p0_2: twos_complement_design port map(TNum1=>operand1,TNum2=>operand2_t,Tsum=>sub_t,Tcarry_out=>undesirable(2));--sub2
  p0_3: twos_complement_design port map(TNum1=>sub_t,TNum2=>one_operand,Tsum=>sub,Tcarry_out=>undesirable(3));--sub2
  
  result <= t_result;
  process(operator,add,sub)--input wont matter in sequential circuit, in combinational circuits it will matter
    begin
         case operator is
           when "00" => t_result <= std_logic_vector(operand1 and operand2); --and
           when "01" => t_result <= std_logic_vector(operand1 or operand2); --or
           when "10" => 
             ----the code below is to help with debugging if overflow and underflow wanted to be handled in future 
             if (((to_integer(signed(operand1))) + (to_integer(signed(operand2)))) >= 127)  then
               overflow_flag <= '1';
               underflow_flag <= '0';
             elsif (((to_integer(signed(operand1))) + (to_integer(signed(operand2)))) <= -255) then
               overflow_flag <= '0';
               underflow_flag <= '1';
             else
               overflow_flag <= '0';
               underflow_flag <= '0';
             end if;
             ----end
             t_result <= std_logic_vector(add); --add
           when "11" => -- sub
             t_result <= sub;
           when others => 
             t_result <= t_result;
        end case;
    end process;
end Alu_arch;