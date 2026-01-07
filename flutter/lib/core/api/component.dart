import 'package:flutter/foundation.dart';
import 'component_context.dart';
import 'component_observable.dart';
import 'component_observer.dart';
import '../internal/component_observable_delegate.dart';

/// Represents a UI component.
abstract class Component implements ComponentObservable {
  /// The context in which this component is operating.
  ComponentContext get context;

  /// Called by [ComponentManager] when the component needs to update its properties.
  void onUpdate(Map<String, dynamic> props);
}

/// Interface for components that can be hidden.
abstract class HideableComponent {
  bool get visible;
}

/// Base component class.
abstract class BaseComponent extends ChangeNotifier implements Component {
  @override
  final ComponentContext context;

  final ComponentObservableDelegate _observableDelegate = ComponentObservableDelegate();

  /// The fully qualified property reference for the current component.
  String pConnectPropertyReference = '';

  BaseComponent(this.context);

  /// Applies the properties to the component. Override in subclasses.
  @protected
  void applyProps(Map<String, dynamic> props);

  @override
  void onUpdate(Map<String, dynamic> props) {
    pConnectPropertyReference = _optString(props, 'pConnectPropertyReference');
    applyProps(props);
    notifyObservers();
    notifyListeners();
  }

  @override
  String toString() => '${context.type}${context.id}';

  /// Helper method to map JSON array with index.
  List<T> mapWithIndex<T>(List<dynamic> array, T Function(int index) transform) {
    return List.generate(array.length, (index) => transform(index));
  }

  @override
  void addObserver(ComponentObserver observer) {
    _observableDelegate.addObserver(observer);
  }

  @override
  void removeObserver(ComponentObserver observer) {
    _observableDelegate.removeObserver(observer);
  }

  @override
  void notifyObservers() {
    _observableDelegate.notifyObservers();
  }

  // JSON helper methods
  String _optString(Map<String, dynamic> props, String key, [String defaultValue = '']) {
    final value = props[key];
    if (value == null) return defaultValue;
    return value.toString();
  }
}
