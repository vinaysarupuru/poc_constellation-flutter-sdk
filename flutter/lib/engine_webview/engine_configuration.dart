import 'dart:convert';
import '../core/constellation_sdk_action.dart';
import '../core/constellation_sdk_engine.dart';

/// Configuration for the WebView engine.
class EngineConfiguration {
  final String url;
  final String version;
  final ConstellationSdkAction action;
  final bool debuggable;

  const EngineConfiguration({
    required this.url,
    required this.version,
    required this.action,
    required this.debuggable,
  });

  String toJsonString() => jsonEncode({
    'url': url,
    'version': version,
    'action': action.toJson(),
    'debuggable': debuggable,
  });
}

/// Simple error implementation for webview engine.
class WebViewEngineError implements EngineError {
  @override
  final String message;

  const WebViewEngineError(this.message);
}
