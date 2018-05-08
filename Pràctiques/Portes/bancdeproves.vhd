ENTITY bancdeproves IS
END bancdeproves;

ARCHITECTURE test OF bancdeproves IS

COMPONENT inversor1
PORT (a: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT and2
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT and3
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT and4
PORT (a,b,c,d: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT or2
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT or3
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL ent1,ent2,ent3,ent4,sortidaAnd2,sortidaAnd3,sortidaAnd4,sortidaOr2,sortidaOr3,sortidaInversor: BIT;
FOR DUT1: and2 USE ENTITY WORK.and2(logica);
FOR DUT2: and3 USE ENTITY WORK.and3(logica);
FOR DUT3: or2 USE ENTITY WORK.or2(logica);
FOR DUT4: or3 USE ENTITY WORK.or3(logica);
FOR DUT5: inversor1 USE ENTITY WORK.inversor1(logica);
FOR DUT6: and4 USE ENTITY WORK.and4(logica);
BEGIN

DUT1: and2 PORT MAP(ent1,ent2,sortidaAnd2);


DUT2: and3 PORT MAP(ent1,ent2,ent3,sortidaAnd3);


DUT3: or2 PORT MAP(ent1,ent2,sortidaOr2);

  
DUT4: or3 PORT MAP(ent1, ent2, ent3, sortidaOr3);


DUT5: inversor1 PORT MAP(ent1,sortidaInversor);
  
DUT6: and4 PORT MAP(ent1,ent2,ent3,ent4,sortidaAnd4);

PROCESS (ent1,ent2,ent3,sortidaAnd2,sortidaAnd3,sortidaOr2,sortidaOr3,sortidaInversor,sortidaAnd4)
BEGIN
ent1<= NOT ent1 AFTER 200ns;
ent2<= NOT ent2 AFTER 100ns;
ent3<= NOT ent3 AFTER 50ns;
ent4<= NOT ent3 AFTER 25ns;
END PROCESS;
END test;