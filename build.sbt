import sbt.{ThisBuild, file}


name := "jurix2022-ihl-devices"
licenses += ("Apache-2.0", url("https://www.apache.org/licenses/LICENSE-2.0"))

version := "0.1"
lazy val AkkaVersion = "2.6.17"
scalaVersion := "2.13.8"
idePackagePrefix := Some("nl.uva.cci")

organization := "nl.uva.cci"

//resolvers += ("agent-script" at "http://145.100.135.102:8081/repository/agent-script/").withAllowInsecureProtocol(true)
unmanagedJars in Compile += file("assets/json-simple-1.1.1.jar")
libraryDependencies += "eflint" %% "java-server" % "0.1.11"

libraryDependencies += "io.github.mostafamohajeri" % "agentscript-grounds_2.13" % "0.47"
libraryDependencies += "io.github.mostafamohajeri" % "agentscript-commons_2.13" % "0.47"

libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.9" % Test
libraryDependencies += "com.typesafe.akka" %% "akka-actor-testkit-typed" % AkkaVersion % Test
libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.9" % Test
libraryDependencies += "net.sourceforge.plantuml" % "plantuml" % "1.2021.12"

libraryDependencies += "org.slf4j" % "slf4j-api" % "1.7.33"
libraryDependencies += "org.slf4j" % "slf4j-log4j12" % "1.7.33"

enablePlugins(AgentScriptCCPlugin)

(agentScriptCC / agentScriptCCPath) in Compile :=  (baseDirectory.value / "src" / "main" / "asl")
Compile / sourceGenerators += (Compile / agentScriptCC).taskValue


classLoaderLayeringStrategy in Test := ClassLoaderLayeringStrategy.ScalaLibrary
parallelExecution in Test := false