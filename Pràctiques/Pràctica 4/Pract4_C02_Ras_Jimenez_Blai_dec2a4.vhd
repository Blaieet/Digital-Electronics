entity dec2a4 is
port(dada: IN BIT_VECTOR(1 DOWNTO 0); control: IN BIT; sortida: OUT BIT_VECTOR(3 DOWNTO 0));
end dec2a4;

architecture estructural of dec2a4 is

component dec1a2 is
port(d,e: IN BIT; z: OUT BIT_VECTOR(1 downto 0));
end component;

component portainv is
port (a: IN BIT; z:  OUT BIT);
end component;

component portaand2 is
port(a,b: IN BIT; z: OUT BIT);
end component;

for dut1: portainv use entity WORK.inv(logica_retard);
for dut2: portaand2 use entity WORK.and2(logica_retard);
for dut3: portaand2 use entity WORK.and2(logica_retard);
for dut4: dec1a2 use entity WORK.dec1a2(ifthen);
for dut5: dec1a2 use entity WORK.dec1a2(estructural);

signal dada1inv, dada1ANDcontrol, dada1invANDcontrol: BIT;
	
begin

dut1: portainv port map (dada(1),dada1inv);
dut2: portaand2 port map (dada1inv,control,dada1invANDcontrol);
dut3: portaand2 port map (dada(1),control,dada1ANDcontrol);
dut4: dec1a2 port map (dada(0), dada1invANDcontrol, sortida(3 downto 2));
dut5: dec1a2 port map (dada(0), dada1ANDcontrol, sortida(1 downto 0));

end estructural;


--- Banc de proves ---

entity banc_proves is
end banc_proves;

architecture test of banc_proves is

component decodificador2a4 is
port(dada: IN BIT_VECTOR(1 DOWNTO 0); control: IN BIT; sortida: OUT BIT_VECTOR(3 DOWNTO 0));
end component;


signal control: BIT;
signal dada: BIT_VECTOR(1 downto 0);
signal sortida: BIT_VECTOR(3 downto 0);

for dut1: decodificador2a4 use entity WORK.dec2a4(estructural);

begin

dut1: decodificador2a4 port map(dada, control, sortida);

process(control, dada)
begin
control <= '1' after 200 ns;
dada(1) <= not dada(1) after 100 ns;
dada(0) <= not dada (0) after 50 ns;


end process;
end test;




