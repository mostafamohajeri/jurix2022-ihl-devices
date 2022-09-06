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

//=======================PREFERENCES==================
// preferences: A target D1 is preferred to D2 of the evma of D1 is more than D2
+!target(D1) >> +!target(D2) :- target(D1) >> target(D2).
target(D1) >> target(D2) :- evma(D1,V1) && evma(D2,V2) && V1 > V2.


//========================PLANS=======================

// MAIN PLAN
// target plan: if the parameter D is already bound (e.g. !target(y)) then checks if it is legal and performs it (prints it)
//              if the parameter D is not bound (free var, e.g. !target(D)) finds the most preferred legal option and performs it.
@preferences
+!target(D)
    : target(D) && dav(D)
        => #println("TARGETING:" + D).

// OTHERS
+?is_legal(D)
    : target(D) && dav(D)
        =>
            #coms.respond(true).

+?is_legal(D)
        => #coms.respond(false).

+?get_all_legal
    : findall(X,dav(X),R)
        =>
            #println(X);
            #coms.respond(R).

+?get_all_most_preferred_legal
    : findall(X,(most_preferred(target(X)) && dav(X)),R)
        => #coms.respond(R).

+?dav :
 findall(X,dav(X),R)
    =>
     #println(X);
     #coms.respond(R).

+?dt :
 findall(X,dt(X),R)
    =>
     #println(X);
     #coms.respond(R).

+?dp :
 findall(X,dt(X),R)
    =>
     #println(X);
     #coms.respond(R).

