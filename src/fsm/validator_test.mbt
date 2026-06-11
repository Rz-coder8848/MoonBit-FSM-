test "validate unreachable states" {
  let builder : Builder[String, String, Unit] = Builder::new()
    .transition(from="Idle", event="Start", to="Running")
    .transition(from="Orphan", event="Foo", to="Bar")
  
  let unreachable = validate(builder, "Idle")
  // Both Orphan and Bar are unreachable from Idle
  inspect!(unreachable.length(), content="2")
}
