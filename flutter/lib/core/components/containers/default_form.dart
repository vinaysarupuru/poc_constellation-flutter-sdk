import '../../api/component_context.dart';
import '../json_utils.dart';
import 'container.dart';

/// Default form component.
class DefaultFormComponent extends ContainerComponent {
  String _instructions = '';

  DefaultFormComponent(ComponentContext context) : super(context);

  String get instructions => _instructions;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _instructions = getString(props, 'instructions');
  }
}
