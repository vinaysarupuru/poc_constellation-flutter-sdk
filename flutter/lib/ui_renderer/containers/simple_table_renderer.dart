import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/simple_table.dart';

/// Renderer for SimpleTable component.
class SimpleTableRenderer implements ComponentRenderer<SimpleTableComponent> {
  @override
  Widget render(SimpleTableComponent component) {
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
