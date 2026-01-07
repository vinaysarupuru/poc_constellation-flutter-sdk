import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/root_container.dart';

/// Renderer for RootContainer component.
class RootContainerRenderer implements ComponentRenderer<RootContainerComponent> {
  @override
  Widget render(RootContainerComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        final viewContainer = component.viewContainer;
        final httpMessages = component.httpMessages;
        final dialogConfig = component.dialogConfig;
        final modalViewContainer = component.modalViewContainer;

        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Display HTTP messages
                if (httpMessages.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.red.shade100,
                    child: Column(
                      children: httpMessages.map((msg) => Text(msg)).toList(),
                    ),
                  ),
                // Render view container
                if (viewContainer != null)
                  Expanded(
                    child: renderComponent(context, viewContainer),
                  ),
              ],
            ),
            // Render modal view container
            if (modalViewContainer != null && modalViewContainer.visible)
              renderComponent(context, modalViewContainer),
            // Render dialog
            if (dialogConfig != null)
              _buildDialog(context, component, dialogConfig),
          ],
        );
      },
    );
  }

  Widget _buildDialog(
    BuildContext context,
    RootContainerComponent component,
    dynamic dialogConfig,
  ) {
    // This is a placeholder - you'd implement proper dialog handling
    return Container();
  }
}
