import 'component.dart';
import 'component_id.dart';
import 'component_context.dart';
import 'component_definition.dart';
import '../components/containers/root_container.dart';
import '../internal/component_manager_impl.dart';

/// Manages components within the system, providing methods to retrieve, add, update, and remove components.
abstract class ComponentManager {
  /// Root container component ID.
  static const rootContainerId = ComponentId(1);

  /// Finds and returns the root container component.
  RootContainerComponent? get rootContainerComponent;

  /// Retrieves all custom components and component overrides definitions.
  List<ComponentDefinition> getCustomComponentDefinitions();

  /// Retrieves a component by its unique identifier.
  Component? getComponent(ComponentId id);

  /// Retrieves all components.
  List<Component> getComponents();

  /// Retrieves multiple components by their unique identifiers.
  List<Component> getComponentsByIds(List<ComponentId> ids);

  /// Adds a new component.
  Component addComponent(ComponentContext context);

  /// Updates the properties of an existing component.
  void updateComponent(ComponentId id, Map<String, dynamic> props);

  /// Removes a component from the system.
  void removeComponent(ComponentId id);

  /// Creates a new instance of `ComponentManager` with optional custom component definitions.
  factory ComponentManager.create({
    List<ComponentDefinition> customDefinitions = const [],
  }) {
    return ComponentManagerImpl(customDefinitions: customDefinitions);
  }
}
