import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/data_reference.dart';

/// Renderer for DataReference component.
class DataReferenceRenderer implements ComponentRenderer<DataReferenceComponent> {
  @override
  Widget render(DataReferenceComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: component.children
              .map((child) => renderComponent(context, child))
              .toList(),
        );
      },
    );
  }
}
