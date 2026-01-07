import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/text_area.dart';
import '../../ui_components/controls/form/text_area.dart';

/// Renderer for TextArea component.
class TextAreaRenderer implements ComponentRenderer<TextAreaComponent> {
  @override
  Widget render(TextAreaComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return TextAreaField(
          value: component.value,
          label: component.label,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          placeholder: component.placeholder,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          maxLength: component.maxLength,
          onValueChange: (value) => component.updateValue(value),
          onFocusChange: (focused) => component.updateFocus(focused),
        );
      },
    );
  }
}
