
ENTITY and2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END and2;

ARCHITECTURE logica OF and2 IS
BEGIN
z<= a AND b;
END logica;
