import 'package:flutter/material.dart';
import 'label.dart';
import 'helper_text.dart';

/// Time picker form field.
class TimeField extends StatelessWidget {
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

  const TimeField({
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
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _parseTime(value) ?? TimeOfDay.now(),
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
                    onValueChange?.call(_formatTime(time));
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
                hintText: placeholder.isNotEmpty ? placeholder : 'HH:MM',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.access_time),
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

  TimeOfDay? _parseTime(String value) {
    if (value.isEmpty) return null;
    try {
      final parts = value.split(':');
      if (parts.length >= 2) {
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
