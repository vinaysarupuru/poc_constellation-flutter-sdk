import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/modal_view_container.dart';

/// Renderer for ModalViewContainer component.
class ModalViewContainerRenderer implements ComponentRenderer<ModalViewContainerComponent> {
  @override
  Widget render(ModalViewContainerComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();

        return Dialog(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title bar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    component.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                // Alert banners
                ...component.alertBanners
                    .map((banner) => renderComponent(context, banner))
                    .toList(),
                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: component.children
                          .map((child) => renderComponent(context, child))
                          .toList(),
                    ),
                  ),
                ),
                // Buttons
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: component.onCancelClick,
                        child: Text(component.cancelButtonLabel),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: component.onSubmitClick,
                        child: Text(component.submitButtonLabel),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
