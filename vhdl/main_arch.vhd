library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_arch is
  generic (b: natural:=255); --b has to be >= 3
  Port ( 
    instruction: in std_logic_vector(b downto 0)  
  );
end main_arch;

architecture Behavioral of main_arch is
signal bh,bh_next,dh,dh_next: integer;
signal stage,regsel,dreg,sreg,aluop: std_logic_vector(1 downto 0);
signal clk,rst,dwrite,readwrite,irload,imload,zero,negative: std_logic;
signal op1op2: std_logic_vector(3 downto 0);
signal reg_current, reg_next: std_logic_vector(31 downto 0);    
signal memory,memory_next: std_logic_vector(39 downto 0);

component stage_counter
  Port(
    clk: in std_logic;
    rst: in std_logic;
    stage: out std_logic_vector(1 downto 0)
  );
end component;
component im_load 
  Port ( 
    irbit7: in std_logic;
    stage: in std_logic_vector(1 downto 0);
    imload: out std_logic
  );
end component;
component ir_load 
 Port ( 
     stage: in std_logic_vector(1 downto 0);
     irload: out std_logic
 );
end component;
component decoder is
    Port (
      instruction: in std_logic_vector(b downto 0);
      stage: in std_logic_vector(1 downto 0);
      bh: in integer;
      op1op2: out std_logic_vector(3 downto 0);
      immediate,datain: out std_logic_vector(7 downto 0);
      sreg,dreg: out std_logic_vector(1 downto 0);
      bh_next: out integer;
      irload: out std_logic
      --irbit: out std_logic_vector(7 downto 0);
      
      --zero: in std_logic;
      --negative: in std_logic;
      
      --addrsel,
      --,imload,regsel,dwrite,readwrite,pcsel,pcloadout: out std_logic;
      --aluop: out std_logic_vector(2 downto 0)
    );
end component;
component reg_file
  Port ( 
    dreg,sreg: in std_logic_vector( 1 downto 0);
    regsel: in std_logic_vector(1 downto 0);
    dwrite,clk: in std_logic;
    reg_current: in std_logic_vector(31 downto 0);
    zero,negative: out std_logic;
    immediate,sbus,datain,aluout: in std_logic_vector(7 downto 0);
    reg_next: out std_logic_vector(31 downto 0);
    memory_next: out std_logic_vector(39 downto 0) 
  );
end component;
component reg_sel
  port(
    op1op2: in std_logic_vector(3 downto 0);
    stage: in std_logic_vector(1 downto 0);
    regsel: out std_logic_vector(1 downto 0)
  ); 
end component;
component dest_reg 
  Port( 
    op1op2: in std_logic_vector(3 downto 0);
    stage: in std_logic_vector( 1 downto 0);
    dwrite: out std_logic
  ); 
end component;
component Alu is
  Port(
      operand1: in std_logic_vector(b downto 0);
      operand2: in std_logic_vector(b downto 0);
      operator: in std_logic_vector(1 downto 0);
      result:  out std_logic_vector(b downto 0)
  );
end component;
component read_write 
  Port ( 
    irbit4: in std_logic;
    irbit5: in std_logic;
    irbit6: in std_logic;
    stage: in std_logic_vector(1 downto 0);
    readwrite: out std_logic
);
end component;

begin

--stage0 ZERO 
p0_0:entity work.stage_counter port map(clk=>clk,rst=>rst,stage=>stage);
--stage1 ONE
p1_0:entity work.decoder port map(instruction=>instruction,stage=>stage,op1op2=>op1op2,immediate=>memory_next(39 downto 32),datain=>memory_next(15 downto 8),sreg=>sreg,dreg=>dreg,bh=>bh,bh_next=>bh_next,irload=>irload);
p1_2:entity work.im_load port map(irbit7=>op1op2(3),stage=>stage,imload=>imload);
p1_3:entity work.read_write port map(irbit4=>op1op2(0),irbit5=>op1op2(1),irbit6=>op1op2(2),stage=>stage,readwrite=>readwrite);
--stage2 TWO
p2_0:entity work.dest_reg port map(op1op2=>op1op2,stage=>stage,dwrite=>dwrite);
p2_1:entity work.reg_sel port map(op1op2=>op1op2,stage=>stage,regsel=>regsel);
--p2_2:entity work.re
--p2_2:entity work.Alu port map(dval(operator=>aluop,result=>dval(7 downto 0),
--         need to turn on         p5:entity work.reg_file port map(dreg=>dreg,sreg=>sreg,dwrite=>dwrite,clk=>clk,regsel=>regsel,reg_current=>reg_current,zero=>zero,negative=>negative,dh=>dh,dh_next=>dh_next,immediate=>memory(39 downto 32),sbus=>memory(31 downto 24),datain=>memory(15 downto 8),aluout=>memory(7 downto 0),reg_next=>reg_next,memory=>memory);

p5:entity work.reg_file port map(dreg=>dreg,sreg=>sreg,regsel=>regsel,dh=>dh,dwrite=>dwrite,clk=>clk,reg_current=>reg_current,zero=>zero,negative=>negative,immediate=>memory(39 downto 32), sbus=>memory(31 downto 24), datain=>memory(15 downto 8),aluout=>memory(7 downto 0),reg_next=>reg_next,memory_next=>memory_next);

--p4:entity work.ir_load port map(stage=>stage,irload=>irload);
process
  begin
    clk<='0';
    if imload = '1' then
      memory <= memory_next;
    else
      memory(31 downto 0) <= memory_next(31 downto 0);
    end if;
    wait for 10ns;
    clk<='1';
    bh<=bh_next;
    dh<=dh_next;
    reg_current <= reg_next;
    if imload = '1' then
      memory <= memory_next;
    else
      memory(31 downto 0) <= memory_next(31 downto 0);
    end if;
    aluop<=op1op2(1 downto 0);
-- immed sbus dbus datain aluot
    wait for 10ns;
end process;

end Behavioral;
