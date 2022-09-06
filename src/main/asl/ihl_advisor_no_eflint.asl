//------------------BELIEFS----------------------
// decisions/targets


//==================RULES=====================
// calculations and rules
evciv(D,V) :-
    findall(A*Y,outcome(D,A,X,Y),AA) &&
    sumlist(AA,V).

evma(D,V) :-
    findall(A*Y,outcome(D,X,A,Y),AA) &&
    sumlist(AA,V).

eqma(X,Y) :-
    evma(X,VMX) &&
    evma(Y,VMY) &&
    VMX == VMY.

lessciv(X,Y) :-
    target(X) && target(Y) &&
    evciv(X,VCX) &&
    evciv(Y,VCY) && VCX < VCY.

prop(X) :-
    evma(X,VMX) &&
    evciv(X,VCX) &&
    prp(Prp) &&
    PVCX is VCX * Prp &&
    VMX =< PVCX.

morerel(X,Y) :-
    evma(X,VMX) && evma(Y,VMY) &&
    evciv(X,VCX) && evciv(Y,VCY) &&
    SATX is VMX * VCX &&
    SATY is VMY * VCY &&
    SATX >= SATY.

dt(X) :-
    target(X) &&
    forall(target(Y), (X !== Y && eqma(X,Y) && lessciv(X,Y)) -> fail || true).

dp(D) :- target(D) && prop(D).

dmh(X) :- target(X) &&
    forall(target(Y), (X !== Y && not morerel(X,Y)) -> fail || true).

dav(D) :- dt(D) && dp(D) && dmh(D).

//========================PLANS=======================

// MAIN PLAN
// target plan: if the parameter D is already bound (e.g. !target(y)) then checks if it is legal and performs it (prints it)
//              if the parameter D is not bound (free var, e.g. !target(D)) finds the most preferred legal option and performs it.


+?calculate
    : findall(X,dav(X),DAV) && findall(Y,dp(Y),DP) && findall(Z,dt(Z),DT) && findall(M,dmh(M),DMH) && findall(evma(T,V),(target(T) && evma(T,V)),EVMA) && findall(evciv(T,V),(target(T) && evciv(T,V)),EVCIV)
        =>
            #println("dav:" + DAV);
            #println("dmh:" + DMH);
            #println("dp:" +  DP);
            #println("dt:" +  DT);
            #println("evma:" + EVMA);
            #println("evciv:" + EVCIV);
            for(I1 in member(I1,DAV)) {
                #coms.inform("IHLDevice",dav(I1));
            };
            for(I2 in member(I2,DP)) {
                #coms.inform("IHLDevice",dp(I2));
            };
            for(I3 in member(I3,DT)) {
                #coms.inform("IHLDevice",dt(I3));
            };
            for(I4 in member(I4,DMH)) {
                #coms.inform("IHLDevice",dmh(I4));
            };
            for(I5 in member(I5,EVMA)) {
                #coms.inform("IHLDevice",I5);
            };

            #coms.respond(true).

