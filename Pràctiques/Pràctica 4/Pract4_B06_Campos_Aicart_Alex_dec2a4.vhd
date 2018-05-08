ENTITY dec2a4 IS
PORT (control: IN BIT;dada: IN BIT_VECTOR(0 TO 1); sortidadecif,sortidadecest: OUT BIT_VECTOR(0 TO 1));
END dec2a4;

ARCHITECTURE estructural OF dec2a4 IS

COMPONENT portanot IS
PORT (a:IN BIT; z : OUT BIT);
END COMPONENT;

COMPONENT portaand IS
PORT (a,b: IN BIT; z : OUT BIT);
END COMPONENT;

COMPONENT dec1a2if IS
PORT (d,e: IN BIT; z: OUT BIT_VECTOR(0 TO 1));
END COMPONENT;

COMPONENT dec1a2est IS
PORT (d,e: IN BIT; z: OUT BIT_VECTOR(0 TO 1));
END COMPONENT;

FOR DUT1: portanot USE ENTITY WORK.inv(logica_retard);
FOR DUT2: portaand USE ENTITY WORK.and2(logica_retard);
FOR DUT3: portaand USE ENTITY WORK.and2(logica_retard);
FOR DUT4: dec1a2if USE ENTITY work.dec1a2(ifthen);
FOR DUT5: dec1a2est USE ENTITY work.dec1a2(estructural);


SIGNAL dada1not,anddada1notcontrol,anddada1control:BIT;

BEGIN

DUT1: portanot PORT MAP (dada(1),dada1not);
DUT2: portaand PORT MAP (dada1not,control,anddada1notcontrol);
DUT3: portaand PORT MAP (dada(1),control,anddada1control);
DUT4: dec1a2if PORT MAP (dada(0),anddada1notcontrol,sortidadecif);
DUT5: dec1a2est PORT MAP (dada(0),anddada1control,sortidadecest);

END estructural;


------BANC DE PROVES-----------

ENTITY banc_proves_dec2a4 IS
END ENTITY;

ARCHITECTURE test OF banc_proves_dec2a4 IS

COMPONENT bloc_dec2a4 IS
PORT (control: IN BIT;dada: IN BIT_VECTOR(0 TO 1); sortidadecif,sortidadecest: OUT BIT_VECTOR(0 TO 1));
END COMPONENT;

FOR DUT1: bloc_dec2a4 USE ENTITY WORK.dec2a4(estructural);

SIGNAL control: BIT;
SIGNAL dada,sortidadecif,sortidadecest: BIT_VECTOR(0 TO 1);

BEGIN 
DUT1: bloc_dec2a4 PORT MAP(control,dada,sortidadecif,sortidadecest);


PROCESS (dada)
BEGIN
dada (0) <= NOT dada (0) AFTER 100 ns;
dada (1) <= NOT dada (1) AFTER 200 ns;
END PROCESS;

PROCESS (control)
BEGIN
control <= NOT control AFTER 400 ns;
END PROCESS;

END test; 
