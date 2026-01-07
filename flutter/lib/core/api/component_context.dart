import 'component_id.dart';
import 'component_type.dart';
import 'component_manager.dart';
import 'component_event.dart';

/// Represents the context of a component.
///
/// [id] The unique identifier of the component.
/// [type] The type of the component.
/// [componentManager] The manager responsible for handling component-related operations.
abstract class ComponentContext {
  ComponentId get id;
  ComponentType get type;
  ComponentManager get componentManager;

  /// Sends an event to the SDK engine related to the component.
  void sendComponentEvent(ComponentEvent event);
}

/// Default implementation of [ComponentContext].
class ComponentContextImpl implements ComponentContext {
  @override
  final ComponentId id;

  @override
  final ComponentType type;

  @override
  final ComponentManager componentManager;

  final void Function(ComponentEvent event) onComponentEvent;

  ComponentContextImpl({
    required this.id,
    required this.type,
    required this.componentManager,
    this.onComponentEvent = _defaultHandler,
  });

  static void _defaultHandler(ComponentEvent event) {}

  @override
  void sendComponentEvent(ComponentEvent event) => onComponentEvent(event);
}
