import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/simple_table_select.dart';

/// Renderer for SimpleTableSelect component.
class SimpleTableSelectRenderer implements ComponentRenderer<SimpleTableSelectComponent> {
  @override
  Widget render(SimpleTableSelectComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (component.child == null) {
          return const SizedBox.shrink();
        }
        return renderComponent(context, component.child!);
      },
    );
  }
}
