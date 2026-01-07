import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';

/// Simple table select component.
class SimpleTableSelectComponent extends BaseComponent {
  Component? _child;

  SimpleTableSelectComponent(ComponentContext context) : super(context);

  Component? get child => _child;

  @override
  void applyProps(Map<String, dynamic> props) {
    final childId = int.parse(getString(props, 'child'));
    _child = context.componentManager.getComponent(ComponentId(childId));
  }
}
