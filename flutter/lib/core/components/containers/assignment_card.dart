import '../../api/component_context.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';
import '../widgets/action_buttons.dart';
import 'container.dart';

/// Assignment card component.
class AssignmentCardComponent extends ContainerComponent {
  ActionButtonsComponent? _actionButtons;

  AssignmentCardComponent(ComponentContext context) : super(context);

  ActionButtonsComponent? get actionButtons => _actionButtons;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    final actionButtonsId = ComponentId(int.parse(getString(props, 'actionButtons')));
    _actionButtons = context.componentManager.getComponent(actionButtonsId) as ActionButtonsComponent?;
  }
}
