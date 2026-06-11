# API Reference

## Builder

### `Builder::new()`
Creates a new `Builder` instance.

### `transition(from, event, to)`
Registers a basic state transition triggered by an event.

### `transition_if(from, event, to, guard_cond)`
Registers a conditionally guarded transition.

### `on_enter(state, callback)`
Registers a callback when entering the specified state.

### `build(initial_state, initial_context)`
Instantiates the runtime `Engine`.

## Engine

### `state()`
Returns the current state.

### `context()`
Returns the current mutated context data.

### `send(event)`
Dispatches an event into the state machine.
