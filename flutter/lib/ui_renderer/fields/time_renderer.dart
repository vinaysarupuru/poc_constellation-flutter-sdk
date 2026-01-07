import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/time.dart';
import '../../ui_components/controls/form/time.dart';

/// Renderer for Time component.
class TimeRenderer implements ComponentRenderer<TimeComponent> {
  @override
  Widget render(TimeComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return TimeField(
          value: component.value,
          label: component.label,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          placeholder: component.placeholder,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          clockFormat: component.clockFormat,
          onValueChange: (value) => component.updateValue(value),
          onFocusChange: (focused) => component.updateFocus(focused),
        );
      },
    );
  }
}
