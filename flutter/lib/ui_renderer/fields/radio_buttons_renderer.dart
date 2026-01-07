import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/radio_buttons.dart';
import '../../ui_components/controls/form/radio_buttons.dart';

/// Renderer for RadioButtons component.
class RadioButtonsRenderer implements ComponentRenderer<RadioButtonsComponent> {
  @override
  Widget render(RadioButtonsComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return RadioButtonsField(
          value: component.value,
          label: component.label,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          options: component.options
              .map((opt) => RadioOption(key: opt.key, label: opt.label))
              .toList(),
          onValueChange: (value) => component.updateValue(value),
        );
      },
    );
  }
}
