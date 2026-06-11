# MoonBit FSM

A lightweight, type-safe Finite State Machine (FSM) core engine tailored for the MoonBit ecosystem. It provides an elegant Builder API to declaratively configure states, events, transitions, and lifecycle callbacks.

## Features
- **Type-safe Builder API**: Construct state machines safely using MoonBit's robust type system.
- **Entry & Exit Callbacks**: Register code to run seamlessly as your states transition.
- **Guard Conditions**: Conditionally block or allow transitions based on runtime state.
- **Zero Dependencies**: 100% written in pure MoonBit, fully ready for high-performance WebAssembly compilation.

## Installation

```sh
moon add Rz-coder8848/moon-fsm
```

## Quick Start

```moonbit
let builder : @fsm.Builder[String, String] = @fsm.Builder::new()
  .transition(from="Idle", event="Start", to="Running")
  .transition(from="Running", event="Stop", to="Stopped")
  .on_enter("Running", fn(state, event) {
    println("Entered \{state} via \{event}")
  })

let machine = builder.build("Idle")

match machine.send("Start") {
  Ok(_) => println("Successfully transitioned to \{machine.state()}")
  Err(e) => println("Error: \{e}")
}
```
