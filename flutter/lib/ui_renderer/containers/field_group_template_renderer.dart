import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/field_group_template.dart';

/// Renderer for FieldGroupTemplate component.
class FieldGroupTemplateRenderer implements ComponentRenderer<FieldGroupTemplateComponent> {
  @override
  Widget render(FieldGroupTemplateComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...component.items.map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.heading,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          if (item.allowDelete)
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => component.deleteItem(item),
                            ),
                        ],
                      ),
                      renderComponent(context, item.component),
                    ],
                  ),
                ),
              );
            }).toList(),
            if (component.allowAddItems)
              TextButton.icon(
                onPressed: component.addItem,
                icon: const Icon(Icons.add),
                label: Text(component.addButtonLabel),
              ),
          ],
        );
      },
    );
  }
}
