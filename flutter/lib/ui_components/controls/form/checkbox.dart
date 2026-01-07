import 'package:flutter/material.dart';
import 'label.dart';
import 'helper_text.dart';

/// Checkbox form field.
class CheckboxField extends StatelessWidget {
  final String value;
  final String label;
  final String caption;
  final String helperText;
  final String validateMessage;
  final bool hideLabel;
  final bool required;
  final bool disabled;
  final bool readOnly;
  final String trueLabel;
  final String falseLabel;
  final ValueChanged<String>? onValueChange;

  const CheckboxField({
    super.key,
    required this.value,
    required this.label,
    this.caption = '',
    this.helperText = '',
    this.validateMessage = '',
    this.hideLabel = false,
    this.required = false,
    this.disabled = false,
    this.readOnly = false,
    this.trueLabel = 'True',
    this.falseLabel = 'False',
    this.onValueChange,
  });

  bool get _isChecked => value.toLowerCase() == 'true';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!hideLabel)
          FormLabel(
            label: label,
            hideLabel: hideLabel,
            required: required,
            disabled: disabled,
            readOnly: readOnly,
          ),
        CheckboxListTile(
          value: _isChecked,
          onChanged: disabled || readOnly
              ? null
              : (bool? newValue) {
                  onValueChange?.call((newValue ?? false).toString());
                },
          title: caption.isNotEmpty ? Text(caption) : null,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
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
