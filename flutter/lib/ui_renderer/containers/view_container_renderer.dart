import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/view_container.dart';

/// Renderer for ViewContainer component.
class ViewContainerRenderer implements ComponentRenderer<ViewContainerComponent> {
  @override
  Widget render(ViewContainerComponent component) {
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
