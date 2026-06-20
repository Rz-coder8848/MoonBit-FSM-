# MoonBit-FSM Architecture

## Overview
MoonBit-FSM is a lightweight, type-safe Finite State Machine library. This document outlines the core architecture and design decisions.

## Core Components

### 1. Engine
The core runtime that holds the current state and processes transitions.

### 2. Builder
The configuration layer used to define states, transitions, and lifecycle hooks.

### 3. Validator
The static analysis layer ensuring the state machine has no isolated states or unreachable transitions.
