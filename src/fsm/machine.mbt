/// Retrieves the current state of the machine.
pub fn state[S, E](self : Machine[S, E]) -> S {
  self.current_state
}
