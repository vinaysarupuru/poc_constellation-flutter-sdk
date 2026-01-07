import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/containers/region.dart';

/// Renderer for Region component.
class RegionRenderer implements ComponentRenderer<RegionComponent> {
  @override
  Widget render(RegionComponent component) {
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
