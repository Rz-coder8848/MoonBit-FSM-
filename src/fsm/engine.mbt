/// Retrieves the current state of the machine.
pub fn state[S, E](self : Machine[S, E]) -> S {
  self.current_state
}

/// Sends an event to the state machine to trigger a transition.
pub fn send[S : Hash + Eq, E : Hash + Eq](self : Machine[S, E], event : E) -> Result[Unit, String] {
  let current = self.current_state
  match self.transitions.get(current) {
    None => Err("No transitions defined for current state")
    Some(state_map) => {
      match state_map.get(event) {
        None => Err("Event not handled in current state")
        Some(next_state) => {
          // Check guard condition if exists
          let allowed = match self.guards.get(current) {
            Some(evt_guards) => {
              match evt_guards.get(event) {
                Some(guard_cond) => guard_cond(current, event)
                None => true
              }
            }
            None => true
          }
          
          if not(allowed) {
            return Err("Transition blocked by guard condition")
          }

          // Execute on_exit for current state
          match self.on_exit.get(current) {
            Some(cb) => cb(current, event)
            None => ()
          }
          
          self.current_state = next_state
          
          // Execute on_enter for next state
          match self.on_enter.get(next_state) {
            Some(cb) => cb(next_state, event)
            None => ()
          }
          
          Ok(())
        }
      }
    }
  }
}

