import '../api/component_observable.dart';
import '../api/component_observer.dart';

/// Internal delegate for ComponentObservable implementation.
class ComponentObservableDelegate implements ComponentObservable {
  final Set<ComponentObserver> _observers = {};

  @override
  void addObserver(ComponentObserver observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(ComponentObserver observer) {
    _observers.remove(observer);
  }

  @override
  void notifyObservers() {
    for (final observer in _observers) {
      observer.onUpdated();
    }
  }
}
