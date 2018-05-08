-- INVERSOR  -----------------------------------------
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

-- AND2 -----------------------------------------
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

-- NOR2 -----------------------------------------
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
--latch D----------------------
ENTITY Latch_D IS
PORT(D,Pre,Clr,Clk: IN BIT; Q,NO_Q: OUT BIT);
END Latch_D;

ARCHITECTURE ifthen OF Latch_D IS
SIGNAL qint: BIT;
BEGIN
PROCESS (D,Pre,Clr,qint)
BEGIN
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
	IF Clr='0' THEN qint<='0' AFTER 2 ns;
	ELSE
		IF Clk'EVENT AND Clk='0' THEN
			IF D = '0' THEN qint<='0' AFTER 6 ns;
			ELSIF D = '1' THEN qint<='1' AFTER 6 ns;
			END IF;
		END IF;
	END IF;
END IF;
END PROCESS;
Q<=qint; 
NO_Q<=NOT qint;
END ifthen;
-- flipflop JK------------------
ENTITY FF_JK IS
PORT(J,K,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END FF_JK;

ARCHITECTURE ifthen OF FF_JK IS
SIGNAL qint: BIT;
BEGIN
PROCESS (J,K,Clk,Pre,Clr)
BEGIN
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
		IF Clk='1' THEN
			IF J='0' AND K='0' AND qint = '0' THEN qint<=qint AFTER 6 ns;
			ELSIF J='0' AND K='0' AND qint = '1' THEN qint<=qint AFTER 6 ns;
			ELSIF J='0' AND K='1' AND qint = '0' THEN qint<=qint AFTER 6 ns;
			ELSIF J='0' AND K='1' AND qint = '1' THEN qint<= NOT qint AFTER 6 ns;
			ELSIF J='1' AND K='0' AND qint = '0' THEN qint<= NOT qint AFTER 6 ns;
			ELSIF J='1' AND K='0' AND qint = '1' THEN qint<=qint AFTER 6 ns;
			ELSIF J='1' AND K='1' AND qint = '0' THEN qint<= NOT qint AFTER 6 ns;
			ELSIF J='1' AND K='1' AND qint = '1' THEN qint<= NOT qint AFTER 6 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;
