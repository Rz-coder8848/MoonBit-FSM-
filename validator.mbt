/// Validates the FSM configuration to detect unreachable states via BFS.
/// Returns an array of unreachable state identifiers.
pub fn validate[S : Hash + Eq, E, Ctx](builder : Builder[S, E, Ctx], initial_state : S) -> Array[S] {
  let reachable = Map::new()
  let queue = [initial_state]
  let mut head = 0
  
  reachable.set(initial_state, true)
  
  while head < queue.length() {
    let current = queue[head]
    head = head + 1
    
    for t in builder.config.transitions {
      if t.from == current {
        if not(reachable.contains(t.to)) {
          reachable.set(t.to, true)
          queue.push(t.to)
        }
      }
    }
  }
  
  let unreachable = []
  for t in builder.config.transitions {
    if not(reachable.contains(t.from)) {
      // simple linear search to avoid duplicates
      let mut found = false
      for u in unreachable {
        if u == t.from { found = true; break }
      }
      if not(found) { unreachable.push(t.from) }
    }
    if not(reachable.contains(t.to)) {
      let mut found = false
      for u in unreachable {
        if u == t.to { found = true; break }
      }
      if not(found) { unreachable.push(t.to) }
    }
  }
  
  unreachable
}
