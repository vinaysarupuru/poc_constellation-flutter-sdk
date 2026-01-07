import '../../api/component_context.dart';
import '../json_utils.dart';
import 'field.dart';

/// Phone field component.
class PhoneComponent extends FieldComponent {
  bool _showCountryCode = true;

  PhoneComponent(ComponentContext context) : super(context);

  bool get showCountryCode => _showCountryCode;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _showCountryCode = getBoolean(props, 'showCountryCode');
  }
}
