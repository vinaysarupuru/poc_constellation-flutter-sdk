import 'package:flutter/material.dart';
import 'label.dart';
import 'helper_text.dart';

/// Date picker form field.
class DateField extends StatelessWidget {
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

  const DateField({
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: disabled || readOnly
              ? null
              : () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _parseDate(value) ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    onValueChange?.call(_formatDate(date));
                  }
                },
          child: AbsorbPointer(
            child: TextFormField(
              controller: TextEditingController(text: value),
              enabled: !disabled,
              decoration: InputDecoration(
                label: FormLabel(
                  label: label,
                  hideLabel: hideLabel,
                  required: required,
                  disabled: disabled,
                  readOnly: readOnly,
                ),
                hintText: placeholder.isNotEmpty ? placeholder : 'YYYY-MM-DD',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.calendar_today),
                errorText: validateMessage.isNotEmpty ? validateMessage : null,
              ),
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

  DateTime? _parseDate(String value) {
    if (value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
