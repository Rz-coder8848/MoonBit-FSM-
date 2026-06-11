/// A Builder for constructing Finite State Machines declaratively.
pub(all) struct Builder[S, E] {
  config : MachineConfig[S, E]
}

/// Creates a new FSM Builder.
pub fn Builder::new[S, E]() -> Builder[S, E] {
  {
    config: {
      transitions: [],
      on_enter: Map::new(),
      on_exit: Map::new(),
    }
  }
}

/// Adds a transition from a specific state to another triggered by an event.
pub fn transition[S, E](self : Builder[S, E], from : S, event : E, to : S) -> Builder[S, E] {
  self.config.transitions.push({ from, to, event, guard_cond: None })
  self
}

/// Adds a transition with a guard condition.
pub fn transition_if[S, E](self : Builder[S, E], from : S, event : E, to : S, guard_cond : Guard[S, E]) -> Builder[S, E] {
  self.config.transitions.push({ from, to, event, guard_cond: Some(guard_cond) })
  self
}

/// Registers a callback to be executed when entering a specific state.
pub fn on_enter[S : Hash + Eq, E](self : Builder[S, E], state : S, callback : Callback[S, E]) -> Builder[S, E] {
  self.config.on_enter.set(state, callback)
  self
}

/// Registers a callback to be executed when exiting a specific state.
pub fn on_exit[S : Hash + Eq, E](self : Builder[S, E], state : S, callback : Callback[S, E]) -> Builder[S, E] {
  self.config.on_exit.set(state, callback)
  self
}

/// Builds the FSM runtime instance starting at the given state.
pub fn build[S : Hash + Eq, E : Hash + Eq](self : Builder[S, E], initial_state : S) -> Machine[S, E] {
  let transitions = Map::new()
  let guards = Map::new()
  
  for t in self.config.transitions {
    let state_map = match transitions.get(t.from) {
      Some(m) => m
      None => {
        let m = Map::new()
        transitions.set(t.from, m)
        m
      }
    }
    state_map.set(t.event, t.to)
    
    match t.guard_cond {
      Some(g) => {
        let state_guards = match guards.get(t.from) {
          Some(m) => m
          None => {
            let m = Map::new()
            guards.set(t.from, m)
            m
          }
        }
        state_guards.set(t.event, g)
      }
      None => ()
    }
  }
  
  {
    transitions,
    guards,
    on_enter: self.config.on_enter,
    on_exit: self.config.on_exit,
    current_state: initial_state,
  }
}



