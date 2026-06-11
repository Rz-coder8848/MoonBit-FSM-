test "engine send operations" {
  let builder : Builder[String, String, Unit] = Builder::new()
    .transition(from="Init", event="Go", to="Done")
  
  let engine = builder.build("Init", ())
  inspect!(engine.state(), content="\"Init\"")
  
  let res = engine.send("Go")
  inspect!(res.is_ok(), content="true")
  inspect!(engine.state(), content="\"Done\"")
}
