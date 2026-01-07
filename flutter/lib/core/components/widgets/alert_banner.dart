import '../../api/component.dart';
import '../../api/component_context.dart';
import '../json_utils.dart';

/// Alert banner variant.
enum AlertBannerVariant {
  urgent,
  warning,
  success,
  info;

  factory AlertBannerVariant.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'URGENT':
        return AlertBannerVariant.urgent;
      case 'WARNING':
        return AlertBannerVariant.warning;
      case 'SUCCESS':
        return AlertBannerVariant.success;
      case 'INFO':
        return AlertBannerVariant.info;
      default:
        return AlertBannerVariant.urgent;
    }
  }
}

/// Alert banner component.
class AlertBannerComponent extends BaseComponent {
  AlertBannerVariant _variant = AlertBannerVariant.urgent;
  List<String> _messages = [];

  AlertBannerComponent(ComponentContext context) : super(context);

  AlertBannerVariant get variant => _variant;
  List<String> get messages => _messages;

  @override
  void applyProps(Map<String, dynamic> props) {
    _variant = AlertBannerVariant.fromString(getString(props, 'variant'));
    final messagesArray = getJSONArray(props, 'messages');
    _messages = List.generate(messagesArray.length, (index) => getStringFromArray(messagesArray, index));
  }
}
