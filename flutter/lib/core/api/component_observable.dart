import 'component_observer.dart';

/// Observable interface that allows to register listeners to be notified on component updates.
abstract class ComponentObservable {
  /// Adds an observer that will be notified when the component is updated.
  void addObserver(ComponentObserver observer);

  /// Removes previously added component observer.
  void removeObserver(ComponentObserver observer);

  /// Notifies all registered observers about an update.
  void notifyObservers();
}
