fn main {
  println("MoonBit FSM CLI v0.2.0")
  let builder : @fsm.Builder[String, String, Unit] = @fsm.Builder::new()
    .transition(from="Locked", event="Coin", to="Unlocked")
    .transition(from="Unlocked", event="Push", to="Locked")
    
  let engine = builder.build("Locked", ())
  println("Initial state: \{engine.state()}")
  
  match engine.send("Coin") {
    Ok(_) => println("Event: Coin -> New state: \{engine.state()}")
    Err(e) => println("Error: \{e}")
  }
}
