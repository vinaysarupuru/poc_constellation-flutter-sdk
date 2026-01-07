import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_type.dart';
import '../../log.dart';
import '../component_types.dart';
import '../json_utils.dart';

/// Cause for unsupported component.
enum UnsupportedCause {
  missingJavascriptImplementation,
  missingComponentDefinition,
  missingComponentRenderer,
  unknownCause,
}

/// Unsupported component placeholder.
class UnsupportedComponent extends BaseComponent implements HideableComponent {
  static const String _tag = 'Unsupported';

  ComponentType _type;
  UnsupportedCause _cause;
  @override
  bool _visible;

  UnsupportedComponent(
    ComponentContext context, {
    ComponentType? type,
    UnsupportedCause cause = UnsupportedCause.unknownCause,
    bool visible = false,
  })  : _type = type ?? const ComponentType('Unknown'),
        _cause = cause,
        _visible = visible,
        super(context);

  ComponentType get componentType => _type;
  UnsupportedCause get cause => _cause;
  @override
  bool get visible => _visible;

  @override
  void applyProps(Map<String, dynamic> props) {
    _type = ComponentType(optString(props, 'type', _type.type));
    _cause = UnsupportedCause.missingJavascriptImplementation;
    _visible = optBoolean(props, 'visible', _visible);
  }

  /// Creates an unsupported component from a context.
  static UnsupportedComponent create(ComponentContext context, {required UnsupportedCause cause}) {
    final newContext = _UnsupportedComponentContext(
      id: context.id,
      type: ComponentTypes.unsupported,
      componentManager: context.componentManager,
    );
    return UnsupportedComponent(
      newContext,
      type: context.type,
      cause: cause,
      visible: true,
    );
  }
}

class _UnsupportedComponentContext implements ComponentContext {
  @override
  final component_id.ComponentId id;

  @override
  final ComponentType type;

  @override
  final component_manager.ComponentManager componentManager;

  _UnsupportedComponentContext({
    required this.id,
    required this.type,
    required this.componentManager,
  });

  @override
  void sendComponentEvent(component_event.ComponentEvent event) {
    Log.w('Unsupported', 'Cannot send event to unsupported: $event');
  }
}

// Import aliases for use in the context class
import '../../api/component_id.dart' as component_id;
import '../../api/component_manager.dart' as component_manager;
import '../../api/component_event.dart' as component_event;
