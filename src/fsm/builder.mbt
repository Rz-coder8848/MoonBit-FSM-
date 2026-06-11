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
  self.config.transitions.push({ from, to, event })
  self
}

