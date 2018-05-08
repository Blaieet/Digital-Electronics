ENTITY and3 IS
PORT(a,b,c: IN BIT; z: OUT BIT);
END and3;

ARCHITECTURE logica OF and3 IS
BEGIN
z<= a AND b AND c;
END logica;
