--- portes

ENTITY and2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END and2;

ARCHITECTURE logica OF and2 IS
BEGIN
z<= a AND b;
END logica;

ENTITY or2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END or2;

ARCHITECTURE logica OF or2 IS
BEGIN
z <= a OR b;
END logica;

ENTITY xor2 IS
PORT (a, b: IN BIT; z: OUT BIT);
END xor2;

ARCHITECTURE logica OF xor2 IS
BEGIN
z<= a XOR b;
END logica;


--- SUMADOR


entity sumador3bits is
port (cin: IN BIT; a,b: IN BIT_VECTOR(2 downto 0); suma_smod_3bits, aib_smod_3bits, aob_smod_3bits: OUT BIT_VECTOR(2 downto 0); cout: OUT BIT);
end sumador3bits;

architecture estructural of sumador3bits is

component and2 is
port(a,b: IN BIT; z: OUT BIT);
end component;

component or2 is
port(a,b: IN BIT; z: OUT BIT);
end component;

component xor2 is
port(a,b: IN BIT; z: OUT BIT);
end component;

FOR xor_1: xor2 use entity WORK.xor2(logica);
for xor_2: xor2 use entity WORK.xor2(logica);
for and_1: and2 use entity WORK.and2(logica);
for or_1: or2 use entity WORK.or2(logica);
for and_2: and2 use entity WORK.and2(logica);
for or_2: or2 use entity WORK.or2(logica);

signal sort_xor,sort_or,sort_and1,sort_and2: BIT_VECTOR (2 DOWNTO 0);

begin
xor_1: xor2 port map (a(0),b(0),sort_xor(0));
xor_2: xor2 port map (sort_xor(1),cin,suma_smod_3bits(0));
and_1: and2 port map (a(1),b(1),sort_and1(0));
or_1: or2 port map (a(2),b(2),sort_or(0));
and_2: and2 port map (sort_or(1),cin,sort_and2(0));
or_2: or2 port map (sort_and1(1),sort_and2(1),cout);

aib_smod_3bit <= sort_and1;
aob_smod_3bit <= sort_or;

end estructural;



--- Banc De probes

entity bdp_sumador3bits is
end bdp_sumador3bits;

architecture test of bdp_sumador3bits is

component bdp_sumador3bits is
port(ent1,ent2,ent3: IN BIT_VECTOR(2 DOWNTO 0); aib,aob: OUT BIT_VECTOR(2 DOWNTO 0));
end component;

signal ent1,ent2,ent3: BIT_VECTOR (2 DOWNTO 0);
signal aib,aob: BIT_VECTOR (2 DOWNTO 0);

FOR DUT: bdp_sumador3bits use entity WORK.bdp_sumador3bits(logica);

begin
DUT: bdp_sumador3bits port map (ent1,ent2,ent3,aob,aib);

process (ent1,ent2,ent3)
begin

ent1<= "001", "101" AFTER 20ns, "001" AFTER 40ns, "011" AFTER 60ns;
ent2<= "001", "101" AFTER 30ns, "011" AFTER 50ns, "010" AFTER 70ns;
ent3<= "011", "100" AFTER 20ns, "011" AFTER 40ns, "101" AFTER 60ns;

end process;
end test;
