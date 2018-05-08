entity bdp_comp4bits is
end bdp_comp4bits;

architecture test of bdp_comp4bits is
  
component comp4bits is
port(enable: IN BIT; paraula_a, paraula_b: IN BIT_VECTOR (3 downto 0); z:OUT BIT_VECTOR (2 downto 0));
end component;

signal enable: BIT;
signal paraula_a, paraula_b: BIT_VECTOR (3 downto 0);
signal z: BIT_VECTOR (2 downto 0);

for dut: comp4bits use entity WORK.comp4bits(ifthen);

begin
dut: comp4bits port map(enable,paraula_a,paraula_b, z);
  
process (paraula_a,paraula_b)
begin
paraula_a (0)<= NOT paraula_a (0) after 50 ns;
paraula_a (1)<= NOT paraula_a (1) after 100 ns;
paraula_a (2)<= NOT paraula_a (2) after 150 ns;
paraula_a (3)<= NOT paraula_a (3) after 150 ns;
paraula_b (0)<= NOT paraula_b (0) after 200 ns;
paraula_b (1)<= NOT paraula_b (1) after 250 ns;
paraula_b (2)<= NOT paraula_b (2) after 300 ns;
paraula_b (3)<= NOT paraula_b (3) after 150 ns;


end process;
end test;