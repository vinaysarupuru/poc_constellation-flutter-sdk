import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/currency.dart';
import '../../ui_components/controls/form/currency.dart';

/// Renderer for Currency component.
class CurrencyRenderer implements ComponentRenderer<CurrencyComponent> {
  @override
  Widget render(CurrencyComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return CurrencyField(
          value: component.value,
          label: component.label,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          placeholder: component.placeholder,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          isoCode: component.isoCode,
          showIsoCode: component.showIsoCode,
          decimalPrecision: component.decimalPrecision,
          onValueChange: (value) => component.updateValue(value),
          onFocusChange: (focused) => component.updateFocus(focused),
        );
      },
    );
  }
}
