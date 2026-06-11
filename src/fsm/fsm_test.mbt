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

test "transition with guard" {
  let builder : Builder[String, String] = Builder::new()
    .transition_if(from="Idle", event="Start", to="Running", guard_cond=fn(_s, _e) { false })
    .transition_if(from="Idle", event="ForceStart", to="Running", guard_cond=fn(_s, _e) { true })
  
  let machine = builder.build("Idle")
  
  let res1 = machine.send("Start")
  inspect!(res1.is_err(), content="true")
  inspect!(machine.state(), content="\"Idle\"")
  
  let res2 = machine.send("ForceStart")
  inspect!(res2.is_ok(), content="true")
  inspect!(machine.state(), content="\"Running\"")
}
