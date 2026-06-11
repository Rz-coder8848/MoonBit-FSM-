/// Internal context manager structure.
/// Abstracting this logic allows future expansion for nested context trees.
pub(all) struct ContextManager[Ctx] {
  mut inner : Ctx
}

/// Creates a new ContextManager.
pub fn ContextManager::new[Ctx](initial : Ctx) -> ContextManager[Ctx] {
  { inner: initial }
}

/// Retrieves the current context value.
pub fn get[Ctx](self : ContextManager[Ctx]) -> Ctx {
  self.inner
}

/// Sets a new context value.
pub fn set[Ctx](self : ContextManager[Ctx], val : Ctx) -> Unit {
  self.inner = val
}
