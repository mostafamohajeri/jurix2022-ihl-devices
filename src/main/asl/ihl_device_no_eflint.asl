//==== PREFERENCES ====
+!engage_legal_target(D1) >> +!engage_legal_target(D2) :- target(D1) >> target(D2).
target(D1) >> target(D2) :- evma(D1,V1) && evma(D2,V2) && V1 > V2.

//==== MAIN TARGETING PLAN ====
// If receives a concrete target it will check if that target is `dav`
// If receives a variable it will find the most preferred `dav` target if any

+!engage =>
    !engage_target(D).

+!engage_target(D) =>
    #coms.ask("IHLAdvisor", calculate);
    #Thread.sleep(#asInteger(2000));
    !engage_legal_target(D).

@preferences
+!engage_legal_target(D)
    : dav(D)
        => #println("TARGETING ... " + D).

+!engage_legal_target(D)
    : not dav(D)
        => #println("Not attacking" + D).

// for adding normative facts
@atomic
+data(Fact) =>
    #coms.inform("IHLAdvisor", Fact).

// for removing normative facts
@atomic
-data(Fact) =>
    #coms.un_inform("IHLAdvisor", Fact).
