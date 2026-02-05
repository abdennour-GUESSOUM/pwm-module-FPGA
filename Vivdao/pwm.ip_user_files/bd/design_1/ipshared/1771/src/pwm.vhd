library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- PWM V1 (S. Rubini)
entity pwm is 
generic ( N : integer := 8 );
port ( clk : in std_logic;
       pwm_sig : out std_logic;
       reset : in std_logic;
       min, max : in std_logic_vector(N-1 downto 0) );
end pwm;

architecture beh of pwm is
  signal cnt     : std_logic_vector(N-1 downto 0);
  signal down_up : std_logic := '1';
begin
  rampe: process(clk, reset)
  begin
    if reset='0' then 
      cnt <= conv_std_logic_vector(0, N);
    elsif clk='0' and clk'event then
      if down_up='0' then
        if cnt=conv_std_logic_vector(0, N) then
          down_up<='1';
          cnt<=conv_std_logic_vector(1, N);
        else
          cnt<=cnt-1;
        end if;
      else
        if cnt=conv_std_logic_vector(2**N-1, N) then
          down_up<='0';
          cnt<=conv_std_logic_vector(2**N-2, N);
        else
          cnt<=cnt+1;
        end if;
      end if;
    end if;
  end process;
  
  pwm_sig<='1' when ( down_up='1' and cnt>=max ) 
                 or ( down_up='0' and cnt>=min )
      else '0';
end beh;

