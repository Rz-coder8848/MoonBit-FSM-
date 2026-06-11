# MoonBit-FSM Architecture

The MoonBit-FSM framework is designed with extreme performance and WebAssembly targets in mind. It is separated into three distinct phases to ensure minimal runtime overhead.

## 1. Definition Phase (`Builder`)
The `Builder` API allows developers to declaratively configure states, events, transition paths, and generic context bindings. It collects these into an intermediate `EngineConfig` struct.

## 2. Static Validation Phase (`Validator`)
Before the engine is ever instantiated in production, developers can run the static validator. Using graph traversal algorithms (Breadth-First Search), the validator detects unreachable states (Orphan Nodes) and dead ends.

## 3. Runtime Execution Phase (`Engine`)
The core `Engine` operates purely on pre-compiled Map lookups. When an event is dispatched:
1. It queries the `transitions` Map.
2. It evaluates any active `guards`.
3. It triggers `on_exit` for the previous state.
4. It updates the state pointer and mutated context.
5. It triggers `on_enter` for the new state.
