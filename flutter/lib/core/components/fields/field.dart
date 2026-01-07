import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_event.dart';
import '../display_mode.dart';
import '../json_utils.dart';

/// Base class for all field components.
abstract class FieldComponent extends BaseComponent implements HideableComponent {
  bool _focused = false;
  String _value = '';
  String _label = '';
  bool _visible = false;
  bool _required = false;
  bool _disabled = false;
  bool _readOnly = false;
  String _placeholder = '';
  String _helperText = '';
  String _validateMessage = '';
  DisplayMode _displayMode = DisplayMode.editable;

  FieldComponent(super.context);

  String get value => _value;
  String get label => _label;
  @override
  bool get visible => _visible;
  bool get required => _required;
  bool get disabled => _disabled;
  bool get readOnly => _readOnly;
  String get placeholder => _placeholder;
  String get helperText => _helperText;
  String get validateMessage => _validateMessage;
  DisplayMode get displayMode => _displayMode;

  @override
  void applyProps(Map<String, dynamic> props) {
    _value = getString(props, 'value');
    _label = getString(props, 'label');
    _visible = optBoolean(props, 'visible', true);
    _required = optBoolean(props, 'required', false);
    _disabled = optBoolean(props, 'disabled', false);
    _readOnly = optBoolean(props, 'readOnly', false);
    _helperText = optString(props, 'helperText');
    _placeholder = optString(props, 'placeholder');
    _validateMessage = optString(props, 'validateMessage');
    _displayMode = DisplayMode.fromString(optString(props, 'displayMode'));
  }

  /// Updates the field value and sends a FieldChange event.
  void updateValue(String newValue) {
    if (_value != newValue) {
      _value = newValue;
      context.sendComponentEvent(ComponentEvent.forFieldChange(newValue));
      notifyListeners();
    }
  }

  /// Updates the field focus and sends a FieldChangeWithFocus event.
  void updateFocus(bool focused) {
    if (_focused != focused) {
      _focused = focused;
      context.sendComponentEvent(ComponentEvent.forFieldChangeWithFocus(_value, focused));
    }
  }
}
