import 'package:flutter/material.dart';
import 'label.dart';
import 'helper_text.dart';

/// DateTime picker form field.
class DateTimeField extends StatelessWidget {
  final String value;
  final String label;
  final String helperText;
  final String validateMessage;
  final bool hideLabel;
  final String placeholder;
  final bool required;
  final bool disabled;
  final bool readOnly;
  final String clockFormat;
  final ValueChanged<String>? onValueChange;
  final ValueChanged<bool>? onFocusChange;

  const DateTimeField({
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
    this.clockFormat = '12',
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
                    initialDate: _parseDateTime(value) ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (date != null && context.mounted) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _parseTimeOfDay(value) ?? TimeOfDay.now(),
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: clockFormat == '24',
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (time != null) {
                      final dateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                      onValueChange?.call(dateTime.toIso8601String());
                    }
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
                hintText: placeholder.isNotEmpty ? placeholder : 'YYYY-MM-DD HH:MM',
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

  DateTime? _parseDateTime(String value) {
    if (value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  TimeOfDay? _parseTimeOfDay(String value) {
    final dateTime = _parseDateTime(value);
    if (dateTime == null) return null;
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}
