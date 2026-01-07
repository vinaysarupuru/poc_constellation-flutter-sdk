import '../../api/component.dart';
import '../../api/component_context.dart';
import '../json_utils.dart';
import 'container.dart';

/// Group component.
class GroupComponent extends ContainerComponent implements HideableComponent {
  @override
  bool _visible = true;
  bool _showHeading = false;
  String _heading = '';
  String _instructions = '';
  bool _collapsible = false;

  GroupComponent(ComponentContext context) : super(context);

  @override
  bool get visible => _visible;
  bool get showHeading => _showHeading;
  String get heading => _heading;
  String get instructions => _instructions;
  bool get collapsible => _collapsible;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _visible = getBoolean(props, 'visible');
    _showHeading = getBoolean(props, 'showHeading');
    _heading = getString(props, 'heading');
    _instructions = getString(props, 'instructions');
    _collapsible = getBoolean(props, 'collapsible');
  }
}
