import '../../api/component_context.dart';
import '../json_utils.dart';
import 'field.dart';

/// Decimal field component.
class DecimalComponent extends FieldComponent {
  int _decimalPrecision = 0;
  bool _showGroupSeparators = false;

  DecimalComponent(ComponentContext context) : super(context);

  int get decimalPrecision => _decimalPrecision;
  bool get showGroupSeparators => _showGroupSeparators;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _decimalPrecision = getInt(props, 'decimalPrecision');
    _showGroupSeparators = getBoolean(props, 'showGroupSeparators');
  }
}
