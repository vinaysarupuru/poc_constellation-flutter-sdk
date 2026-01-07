import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/checkbox.dart';
import '../../ui_components/controls/form/checkbox.dart';

/// Renderer for Checkbox component.
class CheckboxRenderer implements ComponentRenderer<CheckboxComponent> {
  @override
  Widget render(CheckboxComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return CheckboxField(
          value: component.value,
          label: component.label,
          caption: component.caption,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          hideLabel: component.hideLabel,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          trueLabel: component.trueLabel,
          falseLabel: component.falseLabel,
          onValueChange: (value) => component.updateValue(value),
        );
      },
    );
  }
}
