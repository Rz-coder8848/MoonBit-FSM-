test "basic transitions" {
  let builder : Builder[String, String, Unit] = Builder::new()
    .transition(from="Idle", event="Start", to="Running")
    .transition(from="Running", event="Stop", to="Stopped")
  
  let engine = builder.build("Idle", ())
  
  inspect!(engine.state(), content="\"Idle\"")
  
  let res1 = engine.send("Start")
  inspect!(res1.is_ok(), content="true")
  inspect!(engine.state(), content="\"Running\"")
  
  let res2 = engine.send("Stop")
  inspect!(res2.is_ok(), content="true")
  inspect!(engine.state(), content="\"Stopped\"")
}

test "invalid transition" {
  let builder : Builder[String, String, Unit] = Builder::new()
    .transition(from="Idle", event="Start", to="Running")
  
  let engine = builder.build("Idle", ())
  
  let res = engine.send("Stop")
  inspect!(res.is_err(), content="true")
  inspect!(engine.state(), content="\"Idle\"")
}

test "transition with guard" {
  let builder : Builder[String, String, Unit] = Builder::new()
    .transition_if(from="Idle", event="Start", to="Running", guard_cond=fn(_s, _e, _ctx) { false })
    .transition_if(from="Idle", event="ForceStart", to="Running", guard_cond=fn(_s, _e, _ctx) { true })
  
  let engine = builder.build("Idle", ())
  
  let res1 = engine.send("Start")
  inspect!(res1.is_err(), content="true")
  inspect!(engine.state(), content="\"Idle\"")
  
  let res2 = engine.send("ForceStart")
  inspect!(res2.is_ok(), content="true")
  inspect!(engine.state(), content="\"Running\"")
}
