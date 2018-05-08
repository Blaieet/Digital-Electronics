ENTITY or4 IS
PORT(a,b,c,d: IN BIT; z: OUT BIT);
END or4;

ARCHITECTURE logicaretard OF or4 IS
BEGIN
z<= a OR b OR c OR d AFTER 3ns;
END logicaretard;
