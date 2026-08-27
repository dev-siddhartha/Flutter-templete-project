/// Common visual states required by the SLDS handoff criteria.
enum SldsComponentState {
  /// Resting state.
  defaultState,

  /// Pointer hover state.
  hover,

  /// Keyboard or accessibility focus state.
  focus,

  /// Pressed or selected active state.
  active,

  /// Non-interactive state.
  disabled,

  /// In-progress state.
  loading,

  /// Invalid or destructive state.
  error,

  /// No value or no content state.
  empty,

  /// Completed or valid state.
  success,
}

/// Returns whether a state should disable user interaction.
bool sldsStateIsDisabled(SldsComponentState state) {
  return state == SldsComponentState.disabled ||
      state == SldsComponentState.loading;
}
