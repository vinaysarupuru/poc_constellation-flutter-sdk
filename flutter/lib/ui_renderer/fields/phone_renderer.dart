import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/phone.dart';
import '../../ui_components/controls/form/phone.dart';

/// Renderer for Phone component.
class PhoneRenderer implements ComponentRenderer<PhoneComponent> {
  @override
  Widget render(PhoneComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return PhoneField(
          value: component.value,
          label: component.label,
          helperText: component.helperText,
          validateMessage: component.validateMessage,
          placeholder: component.placeholder,
          required: component.required,
          disabled: component.disabled,
          readOnly: component.readOnly,
          showCountryCode: component.showCountryCode,
          onValueChange: (value) => component.updateValue(value),
          onFocusChange: (focused) => component.updateFocus(focused),
        );
      },
    );
  }
}
