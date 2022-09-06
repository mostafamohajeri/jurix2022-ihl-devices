## Proof of concept for paper: **Can a military autonomous device follow International Humanitarian Law?**

## Requirements

To run the code you will need 
* Java 11+
* sbt 1.5.5+
* eFLINT 3 [here](https://gitlab.com/eflint/haskell-implementation)
* eFLINT java API [here](https://gitlab.com/eflint/eflint-actors/java-implementation)

To compile, after installing eFLINT and eFLINT's java API, go to the root directory and run `sbt compile`

## Implementation

The two examples are implemented in two test suites in `/src/test/scala`

The example in `IHLService.scala` utilizes eFLINT as normative reasoner, the norm file for IHL rules is in `/src/main/eflint/ihl.eflint`. This example also utilizes three agents as:
* `ihl_device.asl`
* `ihl_advisor.asl`
* `ihl_scenario.asl`

The example in `IHLServiceNoEFLINT.scala` has the same architecture but without utilizing eFLINT as normative reasoner, the IHL rules are instead implemented within the advisor agent `/src/main/eflint/ihl.eflint` with prolog. This example also utilizes three agents as:
* `ihl_device_no_eflint.asl`
* `ihl_advisor_no_eflint.asl`
* `ihl_scenario_no_eflint.asl`

**In Both Examples the scenario agent includes the targets and outcomes that are defined in the scenario and they can be changed to test different settings**

With the current setting running the corresponding test will result in selecting the only viable target with the output:
`TARGETING ... RelSat1_Light`

NOTE: the non eFLINT version is much faster in terms of execution times and is better suited for testing different scenarios.
