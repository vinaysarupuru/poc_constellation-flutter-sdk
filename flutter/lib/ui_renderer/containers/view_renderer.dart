import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/view.dart';

/// Renderer for View component.
class ViewRenderer implements ComponentRenderer<ViewComponent> {
  @override
  Widget render(ViewComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (component.showLabel && component.label.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  component.label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ...component.children
                .map((child) => renderComponent(context, child))
                .toList(),
          ],
        );
      },
    );
  }
}
