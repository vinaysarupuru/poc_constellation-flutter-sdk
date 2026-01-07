import '../../api/component_context.dart';
import '../json_utils.dart';
import 'field.dart';

/// Time field component.
class TimeComponent extends FieldComponent {
  String _clockFormat = '';

  TimeComponent(ComponentContext context) : super(context);

  String get clockFormat => _clockFormat;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _clockFormat = getString(props, 'clockFormat');
  }
}
