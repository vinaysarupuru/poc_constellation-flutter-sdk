import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/email.dart';
import '../../ui_components/controls/form/email.dart';

/// Renderer for Email component.
class EmailRenderer implements ComponentRenderer<EmailComponent> {
  @override
  Widget render(EmailComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return EmailField(
          value: component.value,
          label: component.label,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          placeholder: component.placeholder,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          onValueChange: (value) => component.updateValue(value),
          onFocusChange: (focused) => component.updateFocus(focused),
        );
      },
    );
  }
}
