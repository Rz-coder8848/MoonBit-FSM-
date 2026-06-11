/// A transition definition specifying the source state, the event that triggers it,
/// and the target state it transitions to.
pub(all) struct Transition[S, E] {
  from : S
  to : S
  event : E
}

/// A callback function that executes during a state lifecycle hook.
pub type Callback[S, E] (S, E) -> Unit

/// Core configuration for a state machine builder.
pub(all) struct MachineConfig[S, E] {
  transitions : Array[Transition[S, E]]
  on_enter : Map[S, Callback[S, E]]
  on_exit : Map[S, Callback[S, E]]
}

/// The runtime instance of the Finite State Machine.
pub(all) struct Machine[S, E] {
  transitions : Map[S, Map[E, S]]
  on_enter : Map[S, Callback[S, E]]
  on_exit : Map[S, Callback[S, E]]
  mut current_state : S
}
