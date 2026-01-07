import '../../api/component_context.dart';
import '../json_utils.dart';
import 'container.dart';

/// Assignment component.
class AssignmentComponent extends ContainerComponent {
  bool _loading = true;

  AssignmentComponent(ComponentContext context) : super(context);

  bool get loading => _loading;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _loading = getBoolean(props, 'loading');
  }
}
