fn main {
  println("--- Game NPC AI Example ---")
  
  let builder : @fsm.Builder[String, String, Unit] = @fsm.Builder::new()
    .transition(from="Patrol", event="PlayerSpotted", to="Chase")
    .transition(from="Chase", event="PlayerLost", to="Search")
    .transition(from="Search", event="Timeout", to="Patrol")
    .transition(from="Chase", event="InAttackRange", to="Attack")
    .transition(from="Attack", event="PlayerOutOfRange", to="Chase")
    .transition(from="Attack", event="PlayerDefeated", to="Patrol")
    
  println("Mermaid Diagram:\n" + @fsm.to_mermaid(builder))
}
