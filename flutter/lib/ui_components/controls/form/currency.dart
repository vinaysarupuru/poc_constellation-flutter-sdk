import 'package:flutter/material.dart';
import 'label.dart';
import 'helper_text.dart';

/// Currency form field.
class CurrencyField extends StatelessWidget {
  final String value;
  final String label;
  final String helperText;
  final String validateMessage;
  final bool hideLabel;
  final String placeholder;
  final bool required;
  final bool disabled;
  final bool readOnly;
  final String isoCode;
  final bool showIsoCode;
  final int decimalPrecision;
  final ValueChanged<String>? onValueChange;
  final ValueChanged<bool>? onFocusChange;

  const CurrencyField({
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
    this.isoCode = 'USD',
    this.showIsoCode = false,
    this.decimalPrecision = 2,
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
          child: TextFormField(
            initialValue: value,
            onChanged: onValueChange,
            enabled: !disabled,
            readOnly: readOnly,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
              prefixText: showIsoCode ? '$isoCode ' : _getCurrencySymbol(isoCode),
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

  String _getCurrencySymbol(String isoCode) {
    switch (isoCode.toUpperCase()) {
      case 'USD':
        return '\$ ';
      case 'EUR':
        return '€ ';
      case 'GBP':
        return '£ ';
      case 'JPY':
        return '¥ ';
      default:
        return '$isoCode ';
    }
  }
}
