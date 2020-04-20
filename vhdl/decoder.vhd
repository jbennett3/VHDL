library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity decoder is
    generic (b: natural:=255); --b has to be >= 3
    Port (
        instruction: in std_logic_vector(b downto 0);
        stage: in std_logic_vector(1 downto 0);
        bh: in integer;
        op1op2: out std_logic_vector(3 downto 0);
        immediate,datain: out std_logic_vector(7 downto 0);
        sreg,dreg,aluop: out std_logic_vector(1 downto 0);
        bh_next: out integer;
        irload: out std_logic
     );
end decoder;

architecture decoder_arch of decoder is

signal irload_t: std_logic;
signal op1op2_t: std_logic_vector(3 downto 0);
signal bh_next_t: integer:=b;
signal immediate_t, irbit_t: std_logic_vector(7 downto 0);
signal sreg_t,dreg_t,aluop_t: std_logic_vector(1 downto 0);

component ir_load 
 Port ( 
     stage: in std_logic_vector(1 downto 0);
     irload: out std_logic
 );
end component;

begin
  p1_1:entity work.ir_load port map(stage=>stage,irload=>irload_t);

  irload <= irload_t;
  op1op2 <= op1op2_t;
  bh_next <= bh_next_t;
  immediate <= immediate_t;
  dreg <= dreg_t;
  sreg <= sreg_t;
  process(instruction, irload_t)
    begin
      if (irload_t = '1') then
        op1op2_t <= instruction(bh downto bh-3);
        --datain_t <= instruction(
        case (instruction(bh downto bh-3)) is
          when "0000" => --AND Rd, Rs
            dreg_t <= instruction(bh-4 downto bh-5);
            sreg_t<=instruction(bh-6 downto bh-7);
            --immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-8;
          when "0001" => --OR Rd, Rs
            dreg_t <= instruction(bh-4 downto bh-5);
            sreg_t<=instruction(bh-6 downto bh-7);
            --immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-8;
          when "0010" => --ADD Rd, Rs
            dreg_t <= instruction(bh-4 downto bh-5);
            sreg_t<=instruction(bh-6 downto bh-7);
            --immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-8;        
          when "0011" => --SUB Rd, Rs
              dreg_t <= instruction(bh-4 downto bh-5);
              sreg_t<=instruction(bh-6 downto bh-7);
              --immediate_t <= instruction(bh-8 downto bh-15);
              bh_next_t <= bh-8;
          when "0100" => --LW Rd, Rs
            dreg_t <= instruction(bh-4 downto bh-5);
            sreg_t<=instruction(bh-6 downto bh-7);
            --immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-8;
          when "0101" => --SW Rd, Rs
            dreg_t <= instruction(bh-4 downto bh-5);
            sreg_t<=instruction(bh-6 downto bh-7);
            --immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-8;
          when "0110" => --MOV Rd, Rs
              dreg_t <= instruction(bh-4 downto bh-5);
              sreg_t<=instruction(bh-6 downto bh-7);
              --immediate_t <= instruction(bh-8 downto bh-15);
              bh_next_t <= bh-8;
          when "1000" => --JEQ Rd, immed
              dreg_t <= instruction(bh-4 downto bh-5);
              --sreg_t<=instruction(bh-6 downto bh-7);
              immediate_t <= instruction(bh-8 downto bh-15);
              bh_next_t <= bh-16;
          when "1001" => --JNE Rd, immed
              dreg_t <= instruction(bh-4 downto bh-5);
              --sreg_t<=instruction(bh-6 downto bh-7);
              immediate_t <= instruction(bh-8 downto bh-15);
              bh_next_t <= bh-16;
          when "1010" => --JGT Rd, immed
              dreg_t <= instruction(bh-4 downto bh-5);
              --sreg_t<=instruction(bh-6 downto bh-7);
              immediate_t <= instruction(bh-8 downto bh-15);
              bh_next_t <= bh-16;
          when "1011" => --JLT Rd, immed
              dreg_t <= instruction(bh-4 downto bh-5);
              --sreg_t<=instruction(bh-6 downto bh-7);
              immediate_t <= instruction(bh-8 downto bh-15);
              bh_next_t <= bh-16;
          when "1100" => --LW Rd, immed
            dreg_t <= instruction(bh-4 downto bh-5);
            --sreg_t<=instruction(bh-6 downto bh-7);
            immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-16;
          when "1101" => --SW Rd, immed
            dreg_t <= instruction(bh-4 downto bh-5);
            --sreg_t<=instruction(bh-6 downto bh-7);
            immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-16; 
          when "1110" => --LI Rd, immed
            dreg_t <= instruction(bh-4 downto bh-5);
            --sreg_t<=instruction(bh-6 downto bh-7);
            immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-16;
          when "1111" => --JMP Rd, immed
            --dreg_t <= instruction(bh-4 downto bh-5);
            --sreg_t<=instruction(bh-6 downto bh-7);
            immediate_t <= instruction(bh-8 downto bh-15);
            bh_next_t <= bh-16; 
          when others =>
            immediate_t <= immediate_t;
            bh_next_t <= bh_next_t;
            dreg_t <= dreg_t;
            sreg_t <= sreg_t;
        end case;
      else
        --need to fix this part I am sending the data every time no matter what
        op1op2_t <= op1op2_t;
        bh_next_t <= bh_next_t;
        dreg_t <= dreg_t;
        sreg_t <= sreg_t;
        immediate_t <= immediate_t;
      end if;
  end process;
end decoder_arch;
