fn main {
  println("--- Traffic Light Example ---")
  
  let builder : @fsm.Builder[String, String, Unit] = @fsm.Builder::new()
    .transition(from="Red", event="Timer", to="Green")
    .transition(from="Green", event="Timer", to="Yellow")
    .transition(from="Yellow", event="Timer", to="Red")
    .transition(from="Red", event="PowerOutage", to="Off")
    .transition(from="Green", event="PowerOutage", to="Off")
    .transition(from="Yellow", event="PowerOutage", to="Off")
    .transition(from="Off", event="PowerRestore", to="Red")
    
  let unreachable = @fsm.validate(builder, "Red")
  println("Unreachable states: \{unreachable.length()}")
  
  println("Mermaid Diagram:\n" + @fsm.to_mermaid(builder))
}
