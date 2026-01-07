import 'package:flutter/material.dart';

/// Data class for button actions.
class ButtonAction {
  final String type;
  final String name;
  final String jsAction;

  const ButtonAction({
    required this.type,
    required this.name,
    required this.jsAction,
  });
}

/// Action buttons widget.
class ActionButtonsWidget extends StatelessWidget {
  final List<ButtonAction> primaryButtons;
  final List<ButtonAction> secondaryButtons;
  final void Function(ButtonAction)? onButtonClick;

  const ActionButtonsWidget({
    super.key,
    this.primaryButtons = const [],
    this.secondaryButtons = const [],
    this.onButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...secondaryButtons.map((button) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                onPressed: () => onButtonClick?.call(button),
                child: Text(button.name),
              ),
            );
          }),
          ...primaryButtons.map((button) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ElevatedButton(
                onPressed: () => onButtonClick?.call(button),
                child: Text(button.name),
              ),
            );
          }),
        ],
      ),
    );
  }
}
