import 'package:flutter/material.dart';

/// Helper text widget for form fields.
class HelperText extends StatelessWidget {
  final String text;
  final String validateMessage;
  final bool disabled;
  final bool readOnly;

  const HelperText({
    super.key,
    this.text = '',
    this.validateMessage = '',
    this.disabled = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (validateMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          validateMessage,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 12,
          ),
        ),
      );
    }

    if (text.isNotEmpty && !disabled && !readOnly) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
