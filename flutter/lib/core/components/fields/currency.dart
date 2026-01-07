import '../../api/component_context.dart';
import '../json_utils.dart';
import 'field.dart';

/// Currency field component.
class CurrencyComponent extends FieldComponent {
  String _isoCode = '';
  bool _showIsoCode = false;
  int _decimalPrecision = 2;

  CurrencyComponent(ComponentContext context) : super(context);

  String get isoCode => _isoCode;
  bool get showIsoCode => _showIsoCode;
  int get decimalPrecision => _decimalPrecision;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _isoCode = getString(props, 'currencyISOCode');
    _showIsoCode = getBoolean(props, 'showISOCode');
    _decimalPrecision = getInt(props, 'decimalPrecision');
  }
}
