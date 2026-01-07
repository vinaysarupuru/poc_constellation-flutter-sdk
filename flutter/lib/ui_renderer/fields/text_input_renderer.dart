import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/text_input.dart';
import '../../ui_components/controls/form/text_input.dart';

/// Renderer for TextInput component.
class TextInputRenderer implements ComponentRenderer<TextInputComponent> {
  @override
  Widget render(TextInputComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return TextInputField(
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
