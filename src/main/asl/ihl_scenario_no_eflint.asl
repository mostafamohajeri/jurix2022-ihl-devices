
+!run =>

    #println("RUN!");
    +data(prp(1));
    +data(target("RelSat1_Heavy"));
    +data(target("RelSat1_Light"));
    +data(target("RelSat2_Heavy"));
    +data(target("RelSat2_Light"));
    +data(target("RelSat3_Heavy"));
    +data(target("RelSat3_Light"));
    +data(target("DataCen_Heavy"));
    +data(target("DataCen_Light"));

    +data(outcome("RelSat1_Heavy",40,50,1));
    +data(outcome("RelSat1_Light",60,50,1));

    +data(outcome("RelSat2_Heavy",70,50,1));
    +data(outcome("RelSat2_Light",80,50,1));

    +data(outcome("RelSat3_Heavy",70,60,1));
    +data(outcome("RelSat3_Light",80,60,1));

    +data(outcome("DataCen_Heavy",20,60,1));
    +data(outcome("DataCen_Light",50,5,1))
    .

+!run2 =>

    #println("RUN!");
    +data(prp(1));
    +data(target("RelSat1_Heavy"));
    +data(target("RelSat1_Light"));
    +data(target("RelSat2_Heavy"));
    +data(target("RelSat2_Light"));
    +data(target("DataCen_Heavy"));
    +data(target("DataCen_Light"));

    +data(outcome("RelSat1_Heavy",15,50,1));
    +data(outcome("RelSat1_Light",40,50,1));

    +data(outcome("RelSat2_Heavy",10,50,1));
    +data(outcome("RelSat2_Light",60,5,1));

    +data(outcome("DataCen_Heavy",20,60,1));
    +data(outcome("DataCen_Light",50,5,1))
    .

+!run3 =>

    #println("RUN!");
    +data(prp(1));
    +data(target("RelSat1_Heavy"));
    +data(target("RelSat1_Light"));
    +data(target("RelSat2_Heavy"));
    +data(target("RelSat2_Light"));
    +data(target("DataCen_Heavy"));
    +data(target("DataCen_Light"));

    +data(outcome("RelSat1_Heavy",70,50,1));
    +data(outcome("RelSat1_Light",80,50,1));

    +data(outcome("RelSat2_Heavy",10,60,1));
    +data(outcome("RelSat2_Light",60,5,1));

    +data(outcome("DataCen_Heavy",1,95,1));
    +data(outcome("DataCen_Light",50,5,1))
    .


@atomic
+data(Fact) =>
    #println(Fact+".");
    #coms.inform("IHLDevice", data(Fact)).

// for removing normative facts
@atomic
-data(Fact) =>
    #coms.un_inform("IHLDevice", (Fact)).


+!go_order(Loc,Meal) :
        restaurant(Loc) && not at(Loc) =>
        V = #String.join("_", Loc, "restaurant").toUpperCase == "FRENCH_RESTAURANT";
        +at(home);
        V = V + 1;
        #println("hello").


