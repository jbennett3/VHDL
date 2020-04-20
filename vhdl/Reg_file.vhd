library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_file is
 Port (
   dreg,sreg: in std_logic_vector( 1 downto 0);
   regsel: in std_logic_vector(1 downto 0);
   dwrite,clk: in std_logic;
   reg_current: in std_logic_vector(31 downto 0);
   immediate,sbus,datain,aluout: in std_logic_vector(7 downto 0);
   dh: in integer;
   dh_next: out integer;
   zero,negative: out std_logic;
   reg_next: out std_logic_vector(31 downto 0);
   memory_next: out std_logic_vector(39 downto 0) 
  );
end Reg_file;

architecture Behavioral of Reg_file is

signal zero_t,negative_t: std_logic;
signal dbus_t, temp: std_logic_vector(7 downto 0);
signal reg_next_t: std_logic_vector(31 downto 0);
signal memory_t: std_logic_vector(39 downto 0);
signal dh_next_t: integer:=dh;

begin
zero<=zero_t;
negative<=negative_t;
memory_next <= memory_t;
  process(clk,dwrite,aluout,immediate,sbus,sreg,dreg)
    begin
      if (regsel = "00") then
          temp <= immediate;
        elsif (regsel = "01") then
          temp <= sbus;
        elsif (regsel = "10") then
          temp <= datain;
        elsif (regsel = "11") then
          temp <= aluout;
        else
          temp <= temp;
        end if;
      if (clk'event and clk='1') then
        --determines the correct dval
        if (dwrite = '1') then --this means that the register gets the dval value
          case dreg is
            when "00" =>
            --the code below is used to change register zero(R0) to dval
              --dval is determined by regsel
              reg_next_t(7 downto 0) <= temp;
--              if (regsel = "00") then
--                reg_next_t(7 downto 0) <= immediate;
--              elsif (regsel = "01") then
--                reg_next_t(7 downto 0) <= sbus;
--              elsif (regsel = "10") then
--                reg_next_t(7 downto 0) <= datain;
--              else
--                reg_next_t(7 downto 0) <= aluout;
--              end if;
            when "01" =>
              reg_next_t(15 downto 8) <= temp;
--              if (regsel = "00") then
--                reg_next_t(15 downto 8) <= immediate;
--              elsif (regsel = "01") then
--                reg_next_t(15 downto 8) <= sbus;
--              elsif (regsel = "10") then
--                reg_next_t(15 downto 8) <= datain;
--              else
--                reg_next_t(15 downto 8) <= aluout;
--              end if;  
            when "10" =>
              reg_next_t(23 downto 16) <= temp;
--              if (regsel = "00") then
--                reg_next_t(23 downto 16) <= immediate;
--             elsif (regsel = "01") then
--               reg_next_t(23 downto 16) <= sbus;
--             elsif (regsel = "10") then
--               reg_next_t(23 downto 16) <= datain;
--              else
--               reg_next_t(23 downto 16) <= aluout;
--              end if;
            when "11" =>
              reg_next_t(31 downto 24) <= temp;
--              if (regsel = "00") then
--                reg_next_t(31 downto 24) <= immediate;
--              elsif (regsel = "01") then
--                reg_next_t(31 downto 24) <= sbus;
--              elsif (regsel = "10") then
--                reg_next_t(31 downto 24) <= datain;
--              else
--                reg_next_t(31 downto 24) <= aluout;
--              end if;
            when others =>
              reg_next_t <= reg_next_t;
          end case;
          memory_t(23 downto 16) <= temp; --sets dbus
          zero_t <= not(temp(0) or temp(1) or temp(2) or temp(3) or temp(4) or temp(5) or temp(6) or temp(7));
          negative_t <= temp(7);
          case sreg is
            when "00" =>
              memory_t(31 downto 24) <= temp;--sets sbus
            when "01" =>
              memory_t(31 downto 24) <= temp;
            when "10" =>
              memory_t(31 downto 24) <= temp;
            when "11" =>
              memory_t(31 downto 24) <= temp;
            when others =>
              memory_t <= memory_t;
          end case;
        else
          case dreg is
            when "00" =>
              memory_t(23 downto 16) <= reg_current(7 downto 0);--sets sbus
            when "01" =>
              memory_t(23 downto 16) <= reg_current(15 downto 8);
            when "10" =>
              memory_t(23 downto 16) <= reg_current(23 downto 16);
            when "11" =>
              memory_t(23 downto 16) <= reg_current(31 downto 24);
            when others =>
              memory_t <= memory_t;
           end case;
              memory_t(23 downto 16) <= temp; --sets dbus
              zero_t <= not(temp(0) or temp(1) or temp(2) or temp(3) or temp(4) or temp(5) or temp(6) or temp(7));
              negative_t <= temp(7);
          case sreg is
            when "00" =>
               memory_t(31 downto 24) <= reg_current(7 downto 0);--sets sbus
            when "01" =>
               memory_t(31 downto 24) <= reg_current(15 downto 8);
            when "10" =>
               memory_t(31 downto 24) <= reg_current(23 downto 16);
            when "11" =>
               memory_t(31 downto 24) <= reg_current(31 downto 24);
            when others =>
               memory_t <= memory_t;
          end case;
        reg_next_t <= reg_next_t;
        end if;
        
        
--                memory_t(23 downto 16) <= immediate; --this is setting dbus
--                zero_t <= not( immediate(0) or immediate(1) or immediate(2) or immediate(3) or immediate(4) or immediate(5) or immediate(6) or immediate(7));
--                negative_t <= immediate(7);
--                if (sreg="00memory_t(31 downto 24) <= immediate; --this is setting sbus             
--              elsif (regsel = "01") then
--                reg_next(7 downto 0) <= sbus; --this is dval(2)
--                memory_t(23 downto 16) <= sbus;
--                zero_t <= not( sbus(0) or sbus(1) or sbus(2) or sbus(3) or sbus(4) or sbus(5) or sbus(6) or sbus(7));
--                negative_t <= sbus(7);
                  --memory_t(31 downto 24) <= sbus;
--              elsif (regsel = "10") then
--                reg_next(7 downto 0) <= datain; --this is dval(1)
--                memory_t(23 downto 16) <= datain; 
--                zero_t <= not( datain(0) or datain(1) or datain(2) or datain(3) or datain(4) or datain(5) or datain(6) or datain(7));
--                negative_t <= datain(7);
--                memory_t(31 downto 24) <= datain;
--              else
--                reg_next(7 downto 0) <= aluout; --this is dval(0) 
--                memory_t(23 downto 16) <= aluout;
--                zero_t <= not( aluout(0) or aluout(1) or aluout(2) or aluout(3) or aluout(4) or aluout(5) or aluout(6) or aluout(7));
--                negative_t <= aluout(7);
--                memory_t(31 downto 24) <= immediate;
--              end if;

--            when "01" =>
--              reg_next(15 downto 8) <= dval;
--              dbus_t<=dval;
--              zero_t <= not( dval(8) or dval(9) or dval(10) or dval(11) or dval(12) or dval(13) or dval(14) or dval(15));
--              negative_t <= dval(15);
--              sbus_t <= dval;
--            when "10"=>
--              reg_next(23 downto 16) <= dval;
--              dbus_t<=dval;
--              zero_t <= not( dval(16) or dval(17) or dval(18) or dval(19) or dval(20) or dval(21) or dval(22) or dval(23));
--              negative_t <= dval(23);
--              sbus_t <= dval;
--            when others =>
--              reg_next(31 downto 24) <= dval;
--              dbus_t<=dval;
--              zero_t <= not( dval(24) or dval(25) or dval(26) or dval(27) or dval(28) or dval(29) or dval(30) or dval(31));
--              negative_t <= dval(31);
--              sbus_t <= dval;                          
--          end case;
--          case sreg is
--            when "00" =>
--              --sbus_t <= 
--            when "01" =>
--            when "10" =>
--            when others =>
--                    end case;  
--        else
--          case dregsel is
--            when "00" =>
--              reg_next(7 downto 0) <= reg_current(7 downto 0);
--              dbus_t<=reg_current(7 downto 0);
--              zero_t <= not( reg_current(0) or reg_current(1) or reg_current(2) or reg_current(3) or reg_current(4) or reg_current(5) or reg_current(6) or reg_current(7));
--              negative_t <= reg_current(7);
--              sbus_t <= reg_current(7 downto 0);
--            when "01" =>
--              reg_next(15 downto 8) <= reg_current(15 downto 8);
--              dbus_t<=reg_current(15 downto 8);
--              zero_t <= not( reg_current(8) or reg_current(9) or reg_current(10) or reg_current(11) or reg_current(12) or reg_current(13) or reg_current(14) or reg_current(15));
--              negative_t <= reg_current(15);
--              sbus_t <= reg_current(15 downto 8);
--             when "10" =>
--               reg_next(23 downto 16) <= reg_current(23 downto 16);
--               dbus_t<=reg_current(23 downto 16);
--               zero_t <= not( reg_current(16) or reg_current(17) or reg_current(18) or reg_current(19) or reg_current(20) or reg_current(21) or reg_current(22) or reg_current(23));
--               negative_t <= reg_current(23);
--               sbus_t <= reg_current(23 downto 16);
--            when others =>  
--              reg_next(31 downto 24) <= reg_current(31 downto 24);
--              dbus_t<=reg_current(31 downto 24);
--              zero_t <= not( reg_current(24) or reg_current(25) or reg_current(26) or reg_current(27) or reg_current(28) or reg_current(29) or reg_current(30) or reg_current(31));
--              negative_t <= reg_current(31);
--              sbus_t <= reg_current(31 downto 24);
--                  end case;
        
      else
        zero_t <= zero_t;
        negative_t <= negative_t;
        memory_t <= memory_t;
      end if;
      
  end process;

end Behavioral;
