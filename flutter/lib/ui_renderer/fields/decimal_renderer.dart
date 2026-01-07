import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/decimal.dart';
import '../../ui_components/controls/form/decimal.dart';

/// Renderer for Decimal component.
class DecimalRenderer implements ComponentRenderer<DecimalComponent> {
  @override
  Widget render(DecimalComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return DecimalField(
          value: component.value,
          label: component.label,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          placeholder: component.placeholder,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          decimalPrecision: component.decimalPrecision,
          showGroupSeparators: component.showGroupSeparators,
          onValueChange: (value) => component.updateValue(value),
          onFocusChange: (focused) => component.updateFocus(focused),
        );
      },
    );
  }
}
