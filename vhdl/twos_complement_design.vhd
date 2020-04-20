library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity twos_complement_design is
  generic(b: natural:=7);
  Port ( 
  -- input values for b-1 bit numbers --
  TNum1: in std_logic_vector(b downto 0);
  TNum2: in std_logic_vector(b downto 0);
  Tsum: out std_logic_vector(b downto 0);
  Tcarry_out: out std_logic
  );
end twos_complement_design;

architecture Behavioral of twos_complement_design is
signal temp_carry: std_logic_vector(b downto 0);

component full_adder_design_file
  Port ( 
  FNum1: in std_logic;  
  FNum2: in std_logic;
  Fcarry_in: in std_logic;
  Fsum: out std_logic;
  Fcarry_out: out std_logic
);
end component;

component half_adder
  Port ( 
  HNum1: in std_logic;  
  HNum2: in std_logic;
  Hsum: out std_logic;
  Hcarry: out std_logic
  );
end component;

begin
h0: half_adder port map (HNum1=>TNum1(0),HNum2=>TNum2(0),Hsum=>Tsum(0),Hcarry=>temp_carry(0));
T_Adder_forG:
  for I in 1 to b generate
    f11: full_adder_design_file port map (FNum1=>TNum1(I),FNum2=>TNum2(I),Fcarry_in=>temp_carry(I-1),Fsum=>Tsum(I),Fcarry_out=>temp_carry(I));
end generate T_Adder_forG;
Tcarry_out <= temp_carry(b);

end Behavioral;
