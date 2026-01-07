import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/dropdown.dart';
import '../../ui_components/controls/form/dropdown.dart';

/// Renderer for Dropdown component.
class DropdownRenderer implements ComponentRenderer<DropdownComponent> {
  @override
  Widget render(DropdownComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return DropdownField(
          value: component.value,
          label: component.label,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          placeholder: component.placeholder,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          options: component.options
              .map((opt) => DropdownOption(key: opt.key, label: opt.label))
              .toList(),
          onValueChange: (value) => component.updateValue(value),
          onFocusChange: (focused) => component.updateFocus(focused),
        );
      },
    );
  }
}
