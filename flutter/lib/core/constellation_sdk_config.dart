import 'api/component_manager.dart';

/// Configuration of Pega Constellation Mobile SDK.
class ConstellationSdkConfig {
  /// URL to Pega server
  final String pegaUrl;

  /// Version of Pega server e.g.: '24.1.0'. Determines Constellation Core JS library version used by SDK.
  final String pegaVersion;

  /// Instance of ComponentManager which is responsible for providing component definitions and manages them in the runtime
  final ComponentManager componentManager;

  /// Flag which allows for debugging of underlying WebView engine
  final bool debuggable;

  ConstellationSdkConfig({
    required this.pegaUrl,
    required this.pegaVersion,
    ComponentManager? componentManager,
    this.debuggable = false,
  }) : componentManager = componentManager ?? ComponentManager.create();
}
