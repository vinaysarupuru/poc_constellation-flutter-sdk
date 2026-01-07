import '../../api/component_context.dart';
import '../json_utils.dart';
import 'field.dart';

/// Text area field component.
class TextAreaComponent extends FieldComponent {
  int _maxLength = 100;

  TextAreaComponent(ComponentContext context) : super(context);

  int get maxLength => _maxLength;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    final maxLengthStr = optString(props, 'maxLength');
    _maxLength = maxLengthStr.isEmpty ? 100 : int.tryParse(maxLengthStr) ?? 100;
  }
}
