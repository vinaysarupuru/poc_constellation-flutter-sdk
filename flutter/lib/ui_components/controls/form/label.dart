import 'package:flutter/material.dart';

/// Label widget for form fields.
class FormLabel extends StatelessWidget {
  final String label;
  final bool hideLabel;
  final bool required;
  final bool disabled;
  final bool readOnly;

  const FormLabel({
    super.key,
    required this.label,
    this.hideLabel = false,
    this.required = false,
    this.disabled = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (hideLabel) {
      return const SizedBox.shrink();
    }

    return Text.rich(
      TextSpan(
        text: label,
        children: required
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: disabled
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
              ]
            : null,
      ),
    );
  }
}
