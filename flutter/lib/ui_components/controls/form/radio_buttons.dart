import 'package:flutter/material.dart';
import 'label.dart';
import 'helper_text.dart';

/// Data class for radio button options.
class RadioOption {
  final String key;
  final String label;

  const RadioOption({required this.key, required this.label});
}

/// Radio buttons form field.
class RadioButtonsField extends StatelessWidget {
  final String value;
  final String label;
  final String helperText;
  final String validateMessage;
  final bool hideLabel;
  final bool required;
  final bool disabled;
  final bool readOnly;
  final List<RadioOption> options;
  final ValueChanged<String>? onValueChange;

  const RadioButtonsField({
    super.key,
    required this.value,
    required this.label,
    this.helperText = '',
    this.validateMessage = '',
    this.hideLabel = false,
    this.required = false,
    this.disabled = false,
    this.readOnly = false,
    this.options = const [],
    this.onValueChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!hideLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FormLabel(
              label: label,
              hideLabel: hideLabel,
              required: required,
              disabled: disabled,
              readOnly: readOnly,
            ),
          ),
        ...options.map((option) {
          return RadioListTile<String>(
            value: option.key,
            groupValue: value,
            onChanged: disabled || readOnly
                ? null
                : (String? newValue) {
                    if (newValue != null) {
                      onValueChange?.call(newValue);
                    }
                  },
            title: Text(option.label),
            contentPadding: EdgeInsets.zero,
          );
        }),
        HelperText(
          text: helperText,
          validateMessage: validateMessage,
          disabled: disabled,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
