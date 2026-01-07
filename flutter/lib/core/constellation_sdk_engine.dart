import 'constellation_sdk_config.dart';
import 'constellation_sdk_action.dart';
import 'environment_info.dart';

/// Constellation SDK Engine that orchestrates Pega application logic.
/// It mediates between UI components and the DX API.
abstract class ConstellationSdkEngine {
  /// Configures the engine with the provided configuration and event handler.
  void configure(ConstellationSdkConfig config, EngineEventHandler handler);

  /// Performs the specified action using the Constellation SDK.
  void performAction(ConstellationSdkAction action);
}

/// Functional interface for handling engine events.
typedef EngineEventHandler = void Function(EngineEvent event);

/// Represents various events that can occur during the lifecycle of the Constellation SDK Engine.
abstract class EngineEvent {
  const EngineEvent();
}

/// Indicates that the engine is loading.
class LoadingEvent extends EngineEvent {
  const LoadingEvent();
}

/// Indicates that the engine is ready.
class ReadyEvent extends EngineEvent {
  final EnvironmentInfo environmentInfo;

  const ReadyEvent(this.environmentInfo);
}

/// Indicates that the engine has finished form processing.
class FinishedEvent extends EngineEvent {
  final String? successMessage;

  const FinishedEvent([this.successMessage]);
}

/// Indicates that an error has occurred in the engine.
class ErrorEvent extends EngineEvent {
  final EngineError error;

  const ErrorEvent(this.error);
}

/// Indicates that the form processing has been cancelled.
class CancelledEvent extends EngineEvent {
  const CancelledEvent();
}

/// Interface for engine errors.
abstract class EngineError {
  String get message;
}

/// Simple implementation of EngineError.
class SimpleEngineError implements EngineError {
  @override
  final String message;

  const SimpleEngineError(this.message);
}
