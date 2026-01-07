import 'package:flutter/material.dart';
import 'label.dart';
import 'helper_text.dart';

/// Data class for dropdown options.
class DropdownOption {
  final String key;
  final String label;

  const DropdownOption({required this.key, required this.label});
}

/// Dropdown form field.
class DropdownField extends StatelessWidget {
  final String value;
  final String label;
  final String helperText;
  final String validateMessage;
  final bool hideLabel;
  final String placeholder;
  final bool required;
  final bool disabled;
  final bool readOnly;
  final List<DropdownOption> options;
  final ValueChanged<String>? onValueChange;
  final ValueChanged<bool>? onFocusChange;

  const DropdownField({
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
    this.options = const [],
    this.onValueChange,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Focus(
          onFocusChange: onFocusChange,
          child: DropdownButtonFormField<String>(
            value: value.isNotEmpty ? value : null,
            onChanged: disabled || readOnly
                ? null
                : (String? newValue) {
                    if (newValue != null) {
                      onValueChange?.call(newValue);
                    }
                  },
            decoration: InputDecoration(
              label: FormLabel(
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
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option.key,
                child: Text(option.label),
              );
            }).toList(),
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
