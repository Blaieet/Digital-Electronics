entity comp4bits is
port(enable: IN BIT; paraula_a,paraula_b: IN BIT_VECTOR (3 DOWNTO 0); z: OUT BIT_VECTOR (2 DOWNTO 0));
end comp4bits;

architecture ifthen of comp4bits is
begin
process(enable, paraula_a, paraula_b)
begin

if enable = '1' then z<= "000";
else
  if (paraula_a > paraula_b) then z<="001" after 5 ns;
    elsif (paraula_a < paraula_b) then z<="100" after 5 ns;
  else z<="010" after 5 ns;
end if;
end if;

end process;
end ifthen;