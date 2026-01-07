import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/list_view_component.dart';

/// Renderer for ListView component.
class ListViewRenderer implements ComponentRenderer<ListViewComponent> {
  @override
  Widget render(ListViewComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (component.label.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  component.label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            // Header row
            Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Row(
                children: component.columnLabels.map((label) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Data rows
            ...component.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == component.selectedItemIndex;

              return InkWell(
                onTap: () => component.onItemSelected(index),
                child: Container(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  child: Row(
                    children: component.columnNames.map((columnName) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(item.data[columnName] ?? ''),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
