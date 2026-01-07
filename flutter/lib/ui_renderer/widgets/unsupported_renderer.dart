import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/widgets/unsupported.dart';

/// Renderer for Unsupported component.
class UnsupportedRenderer implements ComponentRenderer<UnsupportedComponent> {
  @override
  Widget render(UnsupportedComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    'Unsupported Component',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Type: ${component.componentType}'),
              Text('Cause: ${_causeToString(component.cause)}'),
            ],
          ),
        );
      },
    );
  }

  String _causeToString(UnsupportedCause cause) {
    switch (cause) {
      case UnsupportedCause.missingJavascriptImplementation:
        return 'Missing JavaScript implementation';
      case UnsupportedCause.missingComponentDefinition:
        return 'Missing component definition';
      case UnsupportedCause.missingComponentRenderer:
        return 'Missing component renderer';
      case UnsupportedCause.unknownCause:
        return 'Unknown cause';
    }
  }
}
