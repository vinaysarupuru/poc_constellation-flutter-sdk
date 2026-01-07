import 'package:flutter/material.dart';
import 'text_input.dart';

/// Text area form field (multi-line text input).
class TextAreaField extends StatelessWidget {
  final String value;
  final String label;
  final String helperText;
  final String validateMessage;
  final bool hideLabel;
  final String placeholder;
  final bool required;
  final bool disabled;
  final bool readOnly;
  final int maxLength;
  final ValueChanged<String>? onValueChange;
  final ValueChanged<bool>? onFocusChange;

  const TextAreaField({
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
    this.maxLength = 100,
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
      placeholder: placeholder,
      required: required,
      disabled: disabled,
      readOnly: readOnly,
      onValueChange: onValueChange,
      onFocusChange: onFocusChange,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
    );
  }
}
