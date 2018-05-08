
ENTITY circuit IS
PORT (x,clk: IN BIT; z: OUT BIT);
END circuit;

ARCHITECTURE estructural OF circuit IS

COMPONENT portaand IS
PORT (a,b: IN BIT; z : OUT BIT);
END COMPONENT;

COMPONENT portanor IS
PORT (a,b: IN BIT; z : OUT BIT);
END COMPONENT;

COMPONENT porta_Latch_D IS
PORT(D,Pre,Clr,Clk: IN BIT; Q,NO_Q: OUT BIT);
END COMPONENT;

COMPONENT porta_FF_JK IS
PORT(J,K,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END COMPONENT;

FOR DUT1: portaand USE ENTITY WORK.and2(logica_retard);
FOR DUT2: portanor USE ENTITY WORK.nor2(logica_retard);
FOR DUT3: porta_Latch_D USE ENTITY WORK.Latch_D(logica_retard);
FOR DUT4: porta_FF_JK USE ENTITY work.FF_JK(ifthen);
FOR DUT5: portainv USE ENTITY WORK.inv(logica_retard);

SIGNAL sort_and,sort_inv,sort_nor: BIT;

BEGIN

DUT1: portaand PORT MAP(x,NO_Q,sort_and);
DUT2: portanor PORT MAP(sort_inv,Q,sort_nor);
DUT3: porta_Latch_D PORT MAP(x,Clk,Q,NO_Q);
DUT4: porta_FF_JK PORT MAP(sort_and,sort_nor,z);
DUT5: portainv PORT MAP(x,sort_inv)

END estructural;
