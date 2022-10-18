
+!run =>

    #println("RUN!");
    +data(coeff_value(100));
    +data(proportionate_coeff(100));

    +data(target("RelSat1_Heavy"));
    +data(target("RelSat1_Light"));
    +data(target("RelSat2_Heavy"));
    +data(target("RelSat2_Light"));
    +data(target("DataCen_Heavy"));
    +data(target("DataCen_Light"));

    #Thread.sleep(#asInteger(2000));

    +data(outcome("RelSat1_Heavy",40,50,100));
    +data(outcome("RelSat1_Light",60,50,100));

    +data(outcome("RelSat2_Heavy",70,50,100));
    +data(outcome("RelSat2_Light",80,50,100));

    +data(outcome("DataCen_Heavy",20,60,100));
    +data(outcome("DataCen_Light",50,5,100));

    #Thread.sleep(#asInteger(10000))
    .

+!run2 =>

    #println("RUN!");
    +data(coeff_value(100));
    +data(proportionate_coeff(100));

    +data(target("RelSat1_Heavy"));
    +data(target("RelSat1_Light"));
    +data(target("RelSat2_Heavy"));
    +data(target("RelSat2_Light"));
    +data(target("DataCen_Heavy"));
    +data(target("DataCen_Light"));

    +data(outcome("RelSat1_Heavy",15,50,100));
    +data(outcome("RelSat1_Light",40,50,100));

    +data(outcome("RelSat2_Heavy",10,50,100));
    +data(outcome("RelSat2_Light",60,5,100));

    +data(outcome("DataCen_Heavy",20,60,100));
    +data(outcome("DataCen_Light",50,5,100));
    #Thread.sleep(#asInteger(10000))
    .

+!run3 =>

    #println("RUN!");
    +data(coeff_value(100));
    +data(proportionate_coeff(100));

    +data(target("RelSat1_Heavy"));
    +data(target("RelSat1_Light"));
    +data(target("RelSat2_Heavy"));
    +data(target("RelSat2_Light"));
    +data(target("DataCen_Heavy"));
    +data(target("DataCen_Light"));
    #Thread.sleep(#asInteger(2000));
    +data(outcome("RelSat1_Heavy",70,50,100));
    +data(outcome("RelSat1_Light",80,50,100));

    +data(outcome("RelSat2_Heavy",10,60,100));
    +data(outcome("RelSat2_Light",60,5,100));

    +data(outcome("DataCen_Heavy",1,95,100));
    +data(outcome("DataCen_Light",50,5,100));

    #Thread.sleep(#asInteger(10000))
    .


@atomic
+data(Fact) =>
    #println("sending data:"+Fact);
    #coms.inform("IHLDevice", data(Fact)).

// for removing normative facts
@atomic
-data(Fact) =>
    #coms.un_inform("IHLAdvisor", data(Fact)).
