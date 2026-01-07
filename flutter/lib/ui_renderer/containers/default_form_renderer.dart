import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/default_form.dart';

/// Renderer for DefaultForm component.
class DefaultFormRenderer implements ComponentRenderer<DefaultFormComponent> {
  @override
  Widget render(DefaultFormComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (component.instructions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  component.instructions,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ...component.children.map((child) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: renderComponent(context, child),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
