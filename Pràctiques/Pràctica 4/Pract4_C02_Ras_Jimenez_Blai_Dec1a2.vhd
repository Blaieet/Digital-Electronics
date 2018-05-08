entity dec1a2 is
port(d,e: IN BIT; z: OUT BIT_VECTOR(1 downto 0));
end dec1a2;

architecture estructural of dec1a2 is

component portainv is
port(a:in bit; z: out bit);
end component;


component portaand2 is
port(a,b: in bit; z: out bit);
end component;

for dut1: portainv use entity WORK.inv(logica_retard);
for dut2: portaand2 use entity WORK.and2(logica_retard);
for dut3: portaand2 use entity WORK.and2(logica_retard);

signal notd: BIT;

BEGIN

dut1: portainv port map (d,notd);
dut2: portaand2 port map (notd,e,z(0));
dut3: portaand2 port map (d,e,z(1));
end estructural;

architecture ifthen of dec1a2 is
begin
process (e,d)

begin
	if e = '0' then z <= "00" after 3 ns;
		elsif d = '1' then z <= "01" after 3 ns;
		elsif d = '0' then z <= "10" after 3 ns;

end if;
end process;
end ifthen;

