test "basic transitions" {
  let builder : Builder[String, String] = Builder::new()
    .transition(from="Idle", event="Start", to="Running")
    .transition(from="Running", event="Stop", to="Stopped")
  
  let machine = builder.build("Idle")
  
  inspect!(machine.state(), content="\"Idle\"")
  
  let res1 = machine.send("Start")
  inspect!(res1.is_ok(), content="true")
  inspect!(machine.state(), content="\"Running\"")
  
  let res2 = machine.send("Stop")
  inspect!(res2.is_ok(), content="true")
  inspect!(machine.state(), content="\"Stopped\"")
}

test "invalid transition" {
  let builder : Builder[String, String] = Builder::new()
    .transition(from="Idle", event="Start", to="Running")
  
  let machine = builder.build("Idle")
  
  let res = machine.send("Stop")
  inspect!(res.is_err(), content="true")
  inspect!(machine.state(), content="\"Idle\"")
}
