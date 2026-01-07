import 'package:flutter/material.dart';
import 'label.dart';
import 'helper_text.dart';

/// Text input form field.
class TextInputField extends StatelessWidget {
  final String value;
  final String label;
  final String helperText;
  final String validateMessage;
  final bool hideLabel;
  final String placeholder;
  final bool required;
  final bool disabled;
  final bool readOnly;
  final ValueChanged<String>? onValueChange;
  final ValueChanged<bool>? onFocusChange;
  final int maxLines;
  final TextInputType? keyboardType;

  const TextInputField({
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
    this.onValueChange,
    this.onFocusChange,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Focus(
          onFocusChange: onFocusChange,
          child: TextFormField(
            initialValue: value,
            onChanged: onValueChange,
            enabled: !disabled,
            readOnly: readOnly,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: hideLabel ? null : label,
              label: hideLabel
                  ? null
                  : FormLabel(
                      label: label,
                      hideLabel: hideLabel,
                      required: required,
                      disabled: disabled,
                      readOnly: readOnly,
                    ),
              hintText: placeholder,
              border: const OutlineInputBorder(),
              errorText: validateMessage.isNotEmpty ? validateMessage : null,
            ),
          ),
        ),
        HelperText(
          text: helperText,
          validateMessage: '',
          disabled: disabled,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
