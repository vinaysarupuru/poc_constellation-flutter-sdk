import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/date_time.dart';
import '../../ui_components/controls/form/date_time.dart';

/// Renderer for DateTime component.
class DateTimeRenderer implements ComponentRenderer<DateTimeComponent> {
  @override
  Widget render(DateTimeComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return DateTimeField(
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
