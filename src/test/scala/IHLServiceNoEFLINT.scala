package nl.uva.cci

import normativeservices.{Environment, PlantUMLCommunicationLogger}

import akka.actor.testkit.typed.scaladsl.ScalaTestWithActorTestKit
import akka.actor.typed
import akka.actor.typed.scaladsl.AskPattern._
import akka.actor.typed.{ActorSystem, Scheduler}
import akka.util.Timeout
import asl.{ihl_advisor_no_eflint, ihl_device_no_eflint, ihl_scenario_no_eflint}
import bb.expstyla.exp.{StructTerm, VarTerm}
import infrastructure._
import org.scalatest.wordspec.AnyWordSpecLike
import std.DefaultCommunications

import _root_.scala.concurrent.duration._
import scala.concurrent.{Await, ExecutionContextExecutor, Future}

class IHLServiceNoEFLINT extends ScalaTestWithActorTestKit with AnyWordSpecLike {

//  import org.apache.log4j.BasicConfigurator
//  BasicConfigurator.configure()
val logger = PlantUMLCommunicationLogger()
  val loggableComs = new DefaultCommunications()
  Environment.comsLogger = logger
  Environment.logActors(Seq("IHLScenario", "IHLDevice"))


  val mas = MAS()

  override def beforeAll(): Unit = {
    // Create System

    val system: ActorSystem[IMessage] = typed.ActorSystem(mas(), "MAS")


    implicit val timeout: Timeout = 10000.milliseconds
    implicit val ec: ExecutionContextExecutor = system.executionContext
    implicit val scheduler: Scheduler = system.scheduler

    // Ask the system to create agents
    val result: Future[IMessage] = system.ask(ref => AgentRequestMessage(
      Seq(
        AgentRequest(new ihl_advisor_no_eflint(coms = loggableComs).agentBuilder, "IHLAdvisor", 1),
        AgentRequest(new ihl_device_no_eflint(coms = loggableComs).agentBuilder, "IHLDevice", 1),
        AgentRequest(new ihl_scenario_no_eflint(coms = loggableComs).agentBuilder, "IHLScenario", 1),
      ),ref))(timeout,scheduler)
    //wait for response
    println("WAITING RESPONSE")
    val system_ready : Boolean = try {
      val response = Await.result(result, timeout.duration).asInstanceOf[ReadyMessage]
      println("RESPONSE:" + response)
      true
    }
    catch {
      case x : Throwable =>
        x.printStackTrace()
        false
    }

    if(system_ready)
      println("agent created")

  }

  "the agents" should {
    "exist in yellow pages if it was created before" in {
        assert(mas.yellowPages.getAgent("IHLDevice").isDefined)
    }

  }


  "ihl advisor" should {
    "init" in {
      val prob = testKit.createTestProbe[IMessage]()
      mas.yellowPages.getAgent("IHLScenario").get.asInstanceOf[AkkaMessageSource].address()  ! GoalMessage(
        StructTerm("run2",Seq()),AkkaMessageSource(prob.ref)
      )

      val message = prob.receiveMessage();
      Thread.sleep(5000)

    }

//
    "target correctly" in {
      val prob = testKit.createTestProbe[IMessage]()
      println ("targeting")
      mas.yellowPages.getAgent("IHLDevice").get.asInstanceOf[AkkaMessageSource].address()  ! GoalMessage(
        StructTerm("engage_target",Seq(VarTerm("D"))),AkkaMessageSource(prob.ref)
      )

      Thread.sleep(2000)
    }


  }


//  "A normative service agent" should {
//
//    "init" in {
//      val prob = testKit.createTestProbe[IMessage]()
//      mas.yellowPages.getAgent("NSeller").get.asInstanceOf[AkkaMessageSource].address()  ! AskMessage(
//        StructTerm("act",Seq(StructTerm("offer",Seq(StringTerm("Seller"),StringTerm("Buyer"),StringTerm("Book"),IntTerm(5))))),AkkaMessageSource(prob.ref)
//      )
//    }

//  }


  override def afterAll(): Unit = {
    Thread.sleep(5000)
    testKit.shutdownTestKit()
  }
}