import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/integer.dart';
import '../../ui_components/controls/form/integer.dart';

/// Renderer for Integer component.
class IntegerRenderer implements ComponentRenderer<IntegerComponent> {
  @override
  Widget render(IntegerComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return IntegerField(
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
