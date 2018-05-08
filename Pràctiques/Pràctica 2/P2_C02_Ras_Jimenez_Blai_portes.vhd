-- Pregunta 1 (reboot):
-- Es produeix un reboot en el senyal de sortida de l'arquitectura estructural de la funció
-- del exemple perquè tenim un retard en les portes or2 i and2 de 3ns que provoquen l'enderreriment
-- de la funcio i en linstant 206 i 209 es quan torna a començar el període de 3ns i per tant diem que
-- es "reinicia" (reboot)





ENTITY inv IS
PORT (a : IN BIT;
z : OUT BIT);
END inv;

ARCHITECTURE logica OF inv IS
BEGIN
z <= not a;
END logica;

ARCHITECTURE logicaretard OF inv IS
BEGIN
z <= not a AFTER 3 ns;
END logicaretard;


ENTITY and2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END and2;

ARCHITECTURE logica OF and2 IS
BEGIN
z<= a AND b;
END logica;

ARCHITECTURE logicaretard OF and2 IS
BEGIN
z<= a AND b AFTER 3 ns;
END logicaretard;

ENTITY and3 IS
PORT(a,b,c: IN BIT; z: OUT BIT);
END and3;

ARCHITECTURE logicaretard OF and3 IS
BEGIN
z<= a AND b AND c AFTER 3 ns;
END logicaretard;

ENTITY and4 IS
PORT(a,b,c,d: IN BIT; z: OUT BIT);
END and4;

ARCHITECTURE logica OF and4 IS
BEGIN
z<=a AND b AND c AND d;
END logica;

ENTITY or2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END or2;

ARCHITECTURE logica OF or2 IS
BEGIN
z <= a OR b;
END logica;

ENTITY or3 IS
PORT(a,b,c: IN BIT; z: OUT BIT);
END or3;

ARCHITECTURE logica OF or3 IS
BEGIN
z<= a OR b OR c;
END logica;

ENTITY or4 IS
PORT(a,b,c,d: IN BIT; z: OUT BIT);
END or4;

ARCHITECTURE logicaretard OF or4 IS
BEGIN
z<= a OR b OR c OR d AFTER 3 ns;
END logicaretard;

ENTITY xor2 IS
PORT (a, b: IN BIT; z: OUT BIT);
END xor2;

ARCHITECTURE logica OF xor2 IS
BEGIN
z<= a XOR b;
END logica;