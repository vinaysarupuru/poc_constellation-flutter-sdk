import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_event.dart';
import '../json_utils.dart';

/// Data class for an action button.
class ActionButton {
  final String type;
  final String name;
  final String jsAction;

  const ActionButton({
    required this.type,
    required this.name,
    required this.jsAction,
  });
}

/// Action buttons component.
class ActionButtonsComponent extends BaseComponent {
  static const String _mainButtons = 'mainButtons';
  static const String _secondaryButtons = 'secondaryButtons';

  List<ActionButton> _primaryButtons = [];
  List<ActionButton> _secondaryButtons = [];

  ActionButtonsComponent(ComponentContext context) : super(context);

  List<ActionButton> get primaryButtons => _primaryButtons;
  List<ActionButton> get secondaryButtons => _secondaryButtons;

  @override
  void applyProps(Map<String, dynamic> props) {
    _primaryButtons = _toActionButtons(getJSONArray(props, _mainButtons));
    _secondaryButtons = _toActionButtons(getJSONArray(props, _secondaryButtons));
  }

  /// Called when a button is clicked.
  void onClick(ActionButton button) {
    context.sendComponentEvent(
      ComponentEvent.forActionButtonClick(button.type, button.jsAction),
    );
  }

  List<ActionButton> _toActionButtons(List<dynamic> array) {
    return array.map((item) {
      final json = item as Map<String, dynamic>;
      return ActionButton(
        type: getString(json, 'type'),
        name: getString(json, 'name'),
        jsAction: getString(json, 'jsAction'),
      );
    }).toList();
  }
}
