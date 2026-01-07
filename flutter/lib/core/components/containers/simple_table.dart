import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';

/// Simple table component.
class SimpleTableComponent extends BaseComponent {
  Component? _child;

  SimpleTableComponent(ComponentContext context) : super(context);

  /// Child component (usually FieldGroupTemplateComponent, ListViewComponent, or SimpleTableManualComponent)
  Component? get child => _child;

  @override
  void applyProps(Map<String, dynamic> props) {
    final childId = int.parse(getString(props, 'child'));
    _child = childId == -1 ? null : context.componentManager.getComponent(ComponentId(childId));
  }
}
