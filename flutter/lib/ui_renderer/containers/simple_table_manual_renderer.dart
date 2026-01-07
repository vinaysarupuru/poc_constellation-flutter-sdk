import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/simple_table_manual.dart';

/// Renderer for SimpleTableManual component.
class SimpleTableManualRenderer implements ComponentRenderer<SimpleTableManualComponent> {
  @override
  Widget render(SimpleTableManualComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        if (!component.visible) return const SizedBox.shrink();

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
                children: [
                  ...component.columnNames.map((name) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(width: 80), // Space for action buttons
                ],
              ),
            ),
            // Data rows
            ...component.rows.asMap().entries.map((entry) {
              final index = entry.key;
              final row = entry.value;

              return Row(
                children: [
                  ...row.cells.map((cell) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: renderComponent(context, cell.component),
                      ),
                    );
                  }).toList(),
                  SizedBox(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (row.showEditButton)
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => component.editRowInModal(index),
                          ),
                        if (row.showDeleteButton)
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => component.deleteRow(index),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
            // Add row button
            if (component.allowAddRows)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton.icon(
                  onPressed: component.addRow,
                  icon: const Icon(Icons.add),
                  label: Text(component.addButtonLabel),
                ),
              ),
          ],
        );
      },
    );
  }
}
