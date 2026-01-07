import 'package:flutter/material.dart';
import '../component_renderer.dart';
import '../../core/components/widgets/action_buttons.dart';
import '../../ui_components/controls/form/action_buttons.dart';

/// Renderer for ActionButtons component.
class ActionButtonsRenderer implements ComponentRenderer<ActionButtonsComponent> {
  @override
  Widget render(ActionButtonsComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return ActionButtonsWidget(
          primaryButtons: component.primaryButtons
              .map((btn) => ButtonAction(
                    type: btn.type,
                    name: btn.name,
                    jsAction: btn.jsAction,
                  ))
              .toList(),
          secondaryButtons: component.secondaryButtons
              .map((btn) => ButtonAction(
                    type: btn.type,
                    name: btn.name,
                    jsAction: btn.jsAction,
                  ))
              .toList(),
          onButtonClick: (button) {
            final actionButton = ActionButton(
              type: button.type,
              name: button.name,
              jsAction: button.jsAction,
            );
            component.onClick(actionButton);
          },
        );
      },
    );
  }
}
