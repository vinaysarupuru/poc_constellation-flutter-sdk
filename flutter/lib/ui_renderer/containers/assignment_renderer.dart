import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/assignment.dart';

/// Renderer for Assignment component.
class AssignmentRenderer implements ComponentRenderer<AssignmentComponent> {
  @override
  Widget render(AssignmentComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (component.loading) {
          return const Center(child: CircularProgressIndicator());
        }

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
