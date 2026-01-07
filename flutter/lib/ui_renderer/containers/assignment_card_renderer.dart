import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/assignment_card.dart';

/// Renderer for AssignmentCard component.
class AssignmentCardRenderer implements ComponentRenderer<AssignmentCardComponent> {
  @override
  Widget render(AssignmentCardComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...component.children
                    .map((child) => renderComponent(context, child))
                    .toList(),
                if (component.actionButtons != null)
                  renderComponent(context, component.actionButtons!),
              ],
            ),
          ),
        );
      },
    );
  }
}
