entity comp2bits is
port(enable: IN BIT; paraula_a, paraula_b: IN BIT_VECTOR(1 downto 0); z: OUT BIT_VECTOR(2 DOWNTO 0));
end comp2bits;

architecture ifthen of comp2bits is
begin
process(enable, paraula_a, paraula_b)
begin
if enable<= '1' then z<= "000";
else
	if (paraula_a > paraula_b) then z<="001" after 5 ns;
		elsif (paraula_a < paraula_b) then z<="100" after 5 ns;
	else z<="010" after 5 ns;
	end if;
end if;
end process;

end ifthen;

entity bdp_comp2 is
end bdp_comp2;



--- Banc de proves

architecture test of bdp_comp2 is

component comp2bits is
port(enable: IN BIT; paraula_a, paraula_b: IN BIT_VECTOR(1 DOWNTO 0); z: OUT BIT_VECTOR(2 DOWNTO 0));
end component;

signal enable: BIT;
signal paraula_a, paraula_b: BIT_VECTOR (1 DOWNTO 0);
signal z: BIT_VECTOR (2 DOWNTO 0);

FOR DUT: comp2bits use entity WORK.comp2bits(ifthen);

begin
DUT: comp2bits port map (enable,paraula_a, paraula_b, z);

PROCESS
BEGIN
enable<='1'; WAIT FOR 207 ns;
enable<='0'; WAIT FOR 309 ns;
enable<='1'; WAIT FOR 500 ns;
enable<='0';

END PROCESS;



process (paraula_a, paraula_b)
begin
paraula_a (0)<= NOT paraula_a (0) after 50 ns;
paraula_a (1)<= NOT paraula_a (1) after 100 ns;
paraula_b (0)<= NOT paraula_b (0) after 200 ns;
paraula_b (1)<= NOT paraula_b (1) after 300 ns;

end process;
end test;
