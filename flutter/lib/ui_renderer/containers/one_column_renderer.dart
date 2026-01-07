import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/one_column.dart';

/// Renderer for OneColumn component.
class OneColumnRenderer implements ComponentRenderer<OneColumnComponent> {
  @override
  Widget render(OneColumnComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: component.children
              .map((child) => renderComponent(context, child))
              .toList(),
        );
      },
    );
  }
}
