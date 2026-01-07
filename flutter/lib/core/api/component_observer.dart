/// Functional interface for observing component updates.
abstract class ComponentObserver {
  /// Called after the component is updated.
  void onUpdated();
}

/// Simple implementation of [ComponentObserver] that takes a callback function.
class ComponentObserverCallback implements ComponentObserver {
  final void Function() callback;

  ComponentObserverCallback(this.callback);

  @override
  void onUpdated() => callback();
}
