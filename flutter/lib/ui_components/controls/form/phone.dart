import 'package:flutter/material.dart';
import 'text_input.dart';

/// Phone form field.
class PhoneField extends StatelessWidget {
  final String value;
  final String label;
  final String helperText;
  final String validateMessage;
  final bool hideLabel;
  final String placeholder;
  final bool required;
  final bool disabled;
  final bool readOnly;
  final bool showCountryCode;
  final ValueChanged<String>? onValueChange;
  final ValueChanged<bool>? onFocusChange;

  const PhoneField({
    super.key,
    required this.value,
    required this.label,
    this.helperText = '',
    this.validateMessage = '',
    this.hideLabel = false,
    this.placeholder = '',
    this.required = false,
    this.disabled = false,
    this.readOnly = false,
    this.showCountryCode = true,
    this.onValueChange,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      value: value,
      label: label,
      helperText: helperText,
      validateMessage: validateMessage,
      hideLabel: hideLabel,
      placeholder: placeholder.isNotEmpty ? placeholder : '+1 (555) 123-4567',
      required: required,
      disabled: disabled,
      readOnly: readOnly,
      onValueChange: onValueChange,
      onFocusChange: onFocusChange,
      keyboardType: TextInputType.phone,
    );
  }
}
