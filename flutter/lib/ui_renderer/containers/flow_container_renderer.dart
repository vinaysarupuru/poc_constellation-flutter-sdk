import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/flow_container.dart';

/// Renderer for FlowContainer component.
class FlowContainerRenderer implements ComponentRenderer<FlowContainerComponent> {
  @override
  Widget render(FlowContainerComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (component.title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  component.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            // Render alert banners
            ...component.alertBanners
                .map((banner) => renderComponent(context, banner))
                .toList(),
            // Render assignment
            if (component.assignment != null)
              Expanded(
                child: renderComponent(context, component.assignment!),
              ),
          ],
        );
      },
    );
  }
}
