# MoonBit Extended FSM

An Enterprise-grade Extended Finite State Machine (FSM) engine for the MoonBit ecosystem. It supports states, events, transition guards, lifecycle callbacks, context mutations, and static dead-end validation.

## Features
- **Extended State (Context)**: Bind generic business data directly into your state machine.
- **Static Validator**: Automatically detect unreachable or orphaned states via internal graph traversal.
- **Zero Dependencies**: 100% pure MoonBit, fully Wasm ready.

## Quick Start
```moonbit
let builder : @fsm.Builder[String, String, Int] = @fsm.Builder::new()
  .transition(from="Idle", event="Start", to="Running")
  .transition_if(from="Running", event="Stop", to="Idle", guard_cond=fn(_s, _e, ctx) { ctx > 0 })

let engine = builder.build("Idle", 100)
```
