-- Aqui comença la funcio dos:
ENTITY funcio_2 is
PORT (a,b,c,d: IN BIT; f:OUT BIT);
END funcio_2;

ARCHITECTURE logica OF funcio_2 IS
BEGIN
f<=(((NOT a) AND b AND (NOT c)) OR (b AND (NOT d)) OR (a AND c AND d) OR (a AND (NOT d))) XOR (a OR (NOT d));
END logica;

ARCHITECTURE estructural OF funcio_2 IS
COMPONENT portaand2 IS
PORT(a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaor2 IS
PORT(a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portainv IS
PORT(a: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaand3 IS
PORT(a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaor4 IS
PORT(a,b,c,d: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT portaxor2 IS
PORT(a,b: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL inva, invc, invd, alpha, beta, gamma, delta, epsilon, lambda: BIT;
FOR DUT1: portainv USE ENTITY WORK.inversor1(logica);
FOR DUT2: portainv USE ENTITY WORK.inversor1(logica);
FOR DUT3: portainv USE ENTITY WORK.inversor1(logica);
FOR DUT4: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR DUT5: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR DUT6: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT7: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT8: portaor2 USE ENTITY WORK.or2(logica);
FOR DUT9: portaor4 USE ENTITY WORK.or4(logicaretard);
FOR DUT10: portaxor2 USE ENTITY WORK.xor2(logica);

BEGIN
DUT1: portainv PORT MAP(A,inva);
DUT2: portainv PORT MAP(C,invc);
DUT3: portainv PORT MAP(D,invd);
DUT4: portaand3 PORT MAP(inva,B,invc,alpha);
DUT5: portaand3 PORT MAP(A,C,D,gamma);
DUT6: portaand2 PORT MAP(B,invd,beta);
DUT7: portaand2 PORT MAP(A,invd,delta);
DUT8: portaor2 PORT MAP(A,invd,epsilon);
DUT9: portaor4 PORT MAP(alpha,beta,gamma,delta,lambda);
DUT10: portaxor2 PORT MAP(epsilon,lambda,f);
END estructural;

-- Aqui comença el banc de proves de la funcio 2:

ENTITY bancdeproves IS
END bancdeproves;

ARCHITECTURE test_de_proves OF bancdeproves IS

COMPONENT bloc_que_simulem IS
PORT(A,B,C,D: IN BIT; f: OUT BIT);
END COMPONENT;

SIGNAL
senyalA,senyalB,senyalC,senyalD,sortida_f_logica,sortida_f_estructural:BIT;
FOR DUT1: bloc_que_simulem USE ENTITY
WORK.funcio_2(logica);
FOR DUT2: bloc_que_simulem USE ENTITY
WORK.funcio_2(estructural);

BEGIN
DUT1:bloc_que_simulem PORT MAP(senyalA,senyalB,senyalC,senyalD,sortida_f_logica);
DUT2:bloc_que_simulem PORT MAP(senyalA,senyalB,senyalC,senyalD,sortida_f_estructural);
PROCESS (senyalA, senyalB, senyalC,senyalD)


-- Pregunta 2d) El retard no son exclusivament de tota la sortida perque una cosa es el retard de la
-- sortida de les portes o components i l'altre el retard de les sortides en si (a,b,c,d) per aixo
-- hi ha aquestes diferencies, no son iguals, de 3ns a 50ns. 


	BEGIN
senyalA <= NOT senyalA AFTER 20ns;
senyalB <= NOT senyalB AFTER 15ns;
senyalC <= NOT senyalC AFTER 10ns;
senyalD <= NOT senyalD AFTER 5ns;
	END PROCESS;

-- Pregunta 2e) El comportament de la funcio es diferent perque estem fent variar les senyals d'entrada
-- del banc de prova variin cada 5ns; mentre que les senyals externes varien cada 50, i la de les portes
-- cada 3ns. Per tant, al simular veiem que la sortida_f_logica es va allargant i va creixent mes a 
-- mesura que pasen els ns, comença de 5 en 5 despres, puja a 10, desprès 15 i fins a 20 ns on torna
-- a començar
END test_de_proves;