import '../../api/component_context.dart';
import '../json_utils.dart';
import 'field.dart';

/// Checkbox field component.
class CheckboxComponent extends FieldComponent {
  String _caption = '';
  String _trueLabel = 'True';
  String _falseLabel = 'False';
  bool _hideLabel = false;

  CheckboxComponent(ComponentContext context) : super(context);

  String get caption => _caption;
  String get trueLabel => _trueLabel;
  String get falseLabel => _falseLabel;
  bool get hideLabel => _hideLabel;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _caption = optString(props, 'caption');
    _trueLabel = optString(props, 'trueLabel', 'True');
    _falseLabel = optString(props, 'falseLabel', 'False');
    _hideLabel = optBoolean(props, 'hideLabel', false);
  }
}
