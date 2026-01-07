import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/date.dart';
import '../../ui_components/controls/form/date.dart';

/// Renderer for Date component.
class DateRenderer implements ComponentRenderer<DateComponent> {
  @override
  Widget render(DateComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return DateField(
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
