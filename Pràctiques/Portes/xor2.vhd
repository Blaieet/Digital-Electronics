ENTITY xor2 IS
PORT (a, b: IN BIT; z: OUT BIT);
END xor2;

ARCHITECTURE logica OF xor2 IS
BEGIN
z<= a XOR b;
END logica;