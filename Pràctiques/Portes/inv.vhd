ENTITY inv IS
PORT (a : IN BIT;
z : OUT BIT);
END inv;
ARCHITECTURE logica OF inv IS
BEGIN
z <= not a;
END logica;

