
entity circuit is
port(x,clk: IN BIT; z: OUT BIT);
end circuit;

architecture estructural of circuit is

component inv is
port (a: IN BIT; z: out bit);
end component;

component and2 is
port(a,b: in bit; z: out bit);
end component;

component nor2 is
port(a,b: in bit; z: out bit);
end component;

component latchd is
port(d,clk,preset,clear: IN BIT; q,notq: OUT BIT);
end component;

component FFJK is
port(J,K,clk,preset,clear: IN BIT; q2,notq2: OUT BIT);
end component;

signal xandnotq,notxnorq, notx: BIT;

for dut1: inv use entity WORK.inv(logica_retard);
for dut2: latchd use entity WORK.latchD(ifthen);
for dut3: and2 use entity WORK.and2(logica_retard);
for dut4: nor2 use entity WORK.nor2(logica_retard);
for dut5: FFJK use entity WORK.ffJK(ifthen);



begin
dut1: inv port map(x,notx);
dut2: latchd port map('d','1','1','1');
dut3: and2 port map(x,notq,xandnotq);
dut4: nor2 port map(q,notx,K);
dut5: FFJK port map('J','K','1','1','1');

end estructural;


-- Banc de Proves

ENTITY bdp is
end bdp;

architecture test of bdp is

component latchd is
port(d,clk,preset,clear: IN BIT; q,notq: OUT BIT);
end component;

component FFJK is
port(J,K,clk,preset,clear: IN BIT; q2,notq2: OUT BIT);
end component;

signal ent1,ent2,clock,preset,clear,Dsort_Q,Dsort_noQ,JKsort_Q,JKsort_noQ: BIT;

for dut1: latchd use entity WORK.latchd(ifthen);
for dut2: FFJK use entity WORK.ffJK(ifthen);

begin

dut1: latchd port map(ent1,clock,preset,clear,Dsort_Q,Dsort_noQ);
dut2: FFJK port map(ent1,ent2,clock,preset,clear,JKsort_Q,JKsort_noQ);


ent1 <= NOT ent1 AFTER 1000 ns;
ent2 <= NOT ent2 AFTER 500 ns;
clock <= NOT clock AFTER 200 ns;
preset <= '0', '1' AFTER 100 ns;
clear <= '1','0' AFTER 50 ns, '1' AFTER 400 ns;

END test;





