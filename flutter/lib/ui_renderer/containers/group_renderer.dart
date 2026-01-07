import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/group.dart';

/// Renderer for Group component.
class GroupRenderer implements ComponentRenderer<GroupComponent> {
  @override
  Widget render(GroupComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();

        Widget content = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (component.showHeading && component.heading.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  component.heading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            if (component.instructions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  component.instructions,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ...component.children
                .map((child) => renderComponent(context, child))
                .toList(),
          ],
        );

        if (component.collapsible) {
          return ExpansionTile(
            title: Text(component.heading),
            initiallyExpanded: true,
            children: [content],
          );
        }

        return content;
      },
    );
  }
}
