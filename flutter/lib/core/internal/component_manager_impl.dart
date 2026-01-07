import '../api/component.dart';
import '../api/component_context.dart';
import '../api/component_definition.dart';
import '../api/component_id.dart';
import '../api/component_manager.dart';
import '../api/component_type.dart';
import '../components/component_registry.dart';
import '../components/containers/root_container.dart';
import '../components/widgets/unsupported.dart';
import '../log.dart';

/// Internal implementation of ComponentManager.
class ComponentManagerImpl implements ComponentManager {
  static const String _tag = 'ComponentManager';

  final List<ComponentDefinition> _customDefinitions;
  final Map<ComponentId, Component> _components = {};
  late final Map<ComponentType, ComponentDefinition> _definitions;

  ComponentManagerImpl({
    List<ComponentDefinition> customDefinitions = const [],
  }) : _customDefinitions = customDefinitions {
    _definitions = {
      for (final def in [...ComponentRegistry.defaultDefinitions, ..._customDefinitions])
        def.type: def
    };
  }

  @override
  RootContainerComponent? get rootContainerComponent {
    return getComponent(ComponentManager.rootContainerId) as RootContainerComponent?;
  }

  @override
  List<ComponentDefinition> getCustomComponentDefinitions() => _customDefinitions;

  @override
  Component addComponent(ComponentContext context) {
    final component = _produceComponent(context);
    _components[context.id] = component;
    return component;
  }

  @override
  Component? getComponent(ComponentId id) {
    final component = _components[id];
    if (component == null) {
      Log.w(_tag, 'Cannot find component $id');
    }
    return component;
  }

  @override
  List<Component> getComponents() => _components.values.toList();

  @override
  List<Component> getComponentsByIds(List<ComponentId> ids) {
    return ids.map((id) => getComponent(id)).whereType<Component>().toList();
  }

  @override
  void updateComponent(ComponentId id, Map<String, dynamic> props) {
    final component = getComponent(id);
    if (component != null) {
      try {
        component.onUpdate(props);
      } catch (e) {
        Log.e(_tag, 'Failure during component update: $component, (message: $e)');
      }
    }
  }

  @override
  void removeComponent(ComponentId id) {
    _components.remove(id);
  }

  Component _produceComponent(ComponentContext context) {
    final definition = _definitions[context.type];
    if (definition != null) {
      return definition.producer(context);
    }
    Log.w(_tag, 'Cannot find component definition for ${context.type}');
    return UnsupportedComponent.create(context, cause: UnsupportedCause.missingComponentDefinition);
  }

  /// Helper method to get a typed component.
  static T? getComponentTyped<T extends Component>(ComponentManager manager, ComponentId id) {
    return manager.getComponent(id) as T?;
  }
}
