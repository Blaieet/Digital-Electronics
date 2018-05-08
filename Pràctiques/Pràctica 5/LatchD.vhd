-- Inversor

ENTITY inv IS 
	PORT(a:IN BIT; z:OUT BIT);
END inv;


ARCHITECTURE logica OF inv IS
BEGIN
	z<= NOT a;
END logica;


ARCHITECTURE logica_retard OF inv IS
BEGIN
	z<= NOT a AFTER 5 ns;
END logica_retard;

--And
ENTITY and2 IS
PORT(a,b:IN BIT; z: OUT BIT);
END and2;


ARCHITECTURE logica OF and2 IS
BEGIN
	z<= a AND b;
END logica;

ARCHITECTURE logica_retard OF and2 IS
BEGIN
	z<= a AND b  AFTER 5 ns;
END logica_retard;

-- Nor
ENTITY nor2 IS
	PORT(a,b:IN BIT; z: OUT BIT);
END nor2;


ARCHITECTURE logica OF nor2 IS
BEGIN
	z<= NOT(a OR b);
END logica;

ARCHITECTURE logica_retard OF nor2 IS
BEGIN
	z<= NOT(a OR b)  AFTER 5 ns;
END logica_retard;

--LatchD

entity latchD is
port(d,clk,preset,clear: IN BIT; q,notq: OUT BIT);
end latchD;

architecture ifthen of latchD is

signal qinterna: BIT;

begin

process (clk,preset,clear)

begin

if preset='0' then qinterna<='1' after 2 ns;
else
	if clear='0' then qinterna<='0' after 2 ns;
	else
		if (clk='1') then
			qinterna<=d after 6 ns;
		else
			qinterna<=qinterna after 6 ns;
		end if;

	end if;
end if;
end process;


q<=qinterna; notq<=NOT qinterna;

end ifthen;

-- Flip-Flop JK

entity ffJK is

port(J,K,clk,preset,clear: IN BIT; q2,notq2: OUT BIT);

end ffJK;

architecture ifthen of ffJK is

signal q2interna: BIT;

begin

process(J,K,clk,preset,clear)

begin

if preset='0' then q2interna<='1' after 2 ns;
else
	if clear='0' then q2interna<='0' after 2 ns;
	else
		if (clk'event and clk='1') then
			if (J='0' and K='0') then
				q2interna<=q2interna;
			elsif (J='1' and K='1') then
				q2interna<=NOT q2interna after 6 ns;
			elsif (J='0' and K='1') then
				q2interna<='0' after 6 ns;
		else
			q2interna<='1' after 6 ns;
		end if;
		end if;
	end if;
end if;
end process;

q2<=q2interna; notq2<=NOT q2interna;


end ifthen;
		







