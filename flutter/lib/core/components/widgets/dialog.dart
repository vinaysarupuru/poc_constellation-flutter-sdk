/// Dialog configuration.
class DialogConfig {
  final DialogType type;
  final String message;
  final void Function() onConfirm;
  final void Function() onCancel;
  /// Prompt-specific
  final String? promptDefault;
  final void Function(String?)? onPromptConfirm;

  const DialogConfig({
    required this.type,
    required this.message,
    this.onConfirm = _defaultCallback,
    this.onCancel = _defaultCallback,
    this.promptDefault,
    this.onPromptConfirm,
  });

  static void _defaultCallback() {}
}

/// Dialog type.
enum DialogType {
  alert,
  confirm,
  prompt,
}
