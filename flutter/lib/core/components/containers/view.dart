import '../../api/component.dart';
import '../../api/component_context.dart';
import '../json_utils.dart';
import 'container.dart';

/// View component that displays child components.
class ViewComponent extends ContainerComponent implements HideableComponent {
  bool _visible = false;
  String _label = '';
  bool _showLabel = false;

  ViewComponent(ComponentContext context) : super(context);

  @override
  bool get visible => _visible;
  String get label => _label;
  bool get showLabel => _showLabel;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _visible = getString(props, 'visible').toLowerCase() == 'true';
    _label = getString(props, 'label');
    _showLabel = getString(props, 'showLabel').toLowerCase() == 'true';
  }
}
