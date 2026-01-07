import 'dart:async';
import 'constellation_sdk_config.dart';
import 'constellation_sdk_engine.dart';
import 'constellation_sdk_action.dart';
import 'environment_info.dart';
import 'components/containers/root_container.dart';
import 'internal/json_helper.dart';

/// Entry point of Pega Constellation Mobile SDK.
/// It allows to embed Pega form into existing application with the possibility of using customized UI.
/// SDK allows to add new components for not supported or custom components.
abstract class ConstellationSdk {
  /// Stream of SDK states.
  Stream<ConstellationSdkState> get stateStream;

  /// Current state of the SDK.
  ConstellationSdkState get state;

  /// Creates a Pega case.
  ///
  /// [caseClassName] case type class to be created
  /// [startingFields] additional data which can be passed into newly created case
  void createCase(String caseClassName, [Map<String, dynamic> startingFields = const {}]);

  /// Opens an assignment with the given ID.
  ///
  /// [assignmentId] id of the assignment to be opened
  void openAssignment(String assignmentId);

  /// Creates a new [ConstellationSdk] instance.
  factory ConstellationSdk.create({
    required ConstellationSdkConfig config,
    required ConstellationSdkEngine engine,
  }) {
    return _ConstellationSdkImpl(config: config, engine: engine);
  }
}

/// Represents all possible states of ConstellationSdk.
abstract class ConstellationSdkState {
  const ConstellationSdkState();
}

/// Initial state.
class InitialState extends ConstellationSdkState {
  const InitialState();
}

/// Form is loading.
class LoadingState extends ConstellationSdkState {
  const LoadingState();
}

/// Form ready to be displayed.
class ReadyState extends ConstellationSdkState {
  final EnvironmentInfo environmentInfo;
  final RootContainerComponent root;

  const ReadyState({
    required this.environmentInfo,
    required this.root,
  });
}

/// Form could not be loaded, e.g. due to configuration or network issues.
class ErrorState extends ConstellationSdkState {
  final EngineError error;

  const ErrorState(this.error);
}

/// Form processing finished.
class FinishedState extends ConstellationSdkState {
  final String? successMessage;

  const FinishedState([this.successMessage]);
}

/// Form processing cancelled.
class CancelledState extends ConstellationSdkState {
  const CancelledState();
}

/// Internal implementation of ConstellationSdk.
class _ConstellationSdkImpl implements ConstellationSdk {
  final ConstellationSdkConfig _config;
  final ConstellationSdkEngine _engine;

  final StreamController<ConstellationSdkState> _stateController =
      StreamController<ConstellationSdkState>.broadcast();

  ConstellationSdkState _state = const InitialState();

  _ConstellationSdkImpl({
    required ConstellationSdkConfig config,
    required ConstellationSdkEngine engine,
  })  : _config = config,
        _engine = engine {
    _engine.configure(config, _onEngineEvent);
  }

  @override
  Stream<ConstellationSdkState> get stateStream => _stateController.stream;

  @override
  ConstellationSdkState get state => _state;

  @override
  void createCase(String caseClassName, [Map<String, dynamic> startingFields = const {}]) {
    _engine.performAction(CreateCaseAction(
      caseClassName: caseClassName,
      startingFields: startingFields.isNotEmpty ? toJsonElement(startingFields) as Map<String, dynamic>? : null,
    ));
  }

  @override
  void openAssignment(String assignmentId) {
    _engine.performAction(OpenAssignmentAction(assignmentId: assignmentId));
  }

  void _onEngineEvent(EngineEvent event) {
    ConstellationSdkState newState;

    if (event is LoadingEvent) {
      newState = const LoadingState();
    } else if (event is ReadyEvent) {
      newState = ReadyState(
        environmentInfo: event.environmentInfo,
        root: _config.componentManager.rootContainerComponent!,
      );
    } else if (event is FinishedEvent) {
      newState = FinishedState(event.successMessage);
    } else if (event is CancelledEvent) {
      newState = const CancelledState();
    } else if (event is ErrorEvent) {
      newState = ErrorState(event.error);
    } else {
      return;
    }

    _state = newState;
    _stateController.add(newState);
  }
}
