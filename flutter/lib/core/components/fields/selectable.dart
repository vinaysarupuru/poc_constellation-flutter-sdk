import '../../api/component_context.dart';
import '../json_utils.dart';
import 'field.dart';

/// Data class for selectable options.
class SelectableOption {
  final String key;
  final String label;

  const SelectableOption({required this.key, required this.label});
}

/// Base class for components with selectable options.
abstract class SelectableComponent extends FieldComponent {
  List<SelectableOption> _options = [];

  SelectableComponent(ComponentContext context) : super(context);

  List<SelectableOption> get options => _options;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    final optionsArray = getJSONArray(props, 'options');
    _options = List.generate(optionsArray.length, (index) {
      final item = getJsonObject(optionsArray, index);
      return SelectableOption(
        key: getString(item, 'key'),
        label: getString(item, 'label'),
      );
    });
  }
}
