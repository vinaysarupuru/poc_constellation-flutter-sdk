import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/fields/url.dart';
import '../../ui_components/controls/form/url.dart';

/// Renderer for URL component.
class UrlRenderer implements ComponentRenderer<UrlComponent> {
  @override
  Widget render(UrlComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();
        
        return UrlField(
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
