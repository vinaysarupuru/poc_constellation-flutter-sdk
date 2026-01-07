import 'dart:math';
import '../core/constellation_sdk_action.dart';
import '../core/constellation_sdk_config.dart';
import '../core/constellation_sdk_engine.dart';
import '../core/environment_info.dart';
import '../core/api/component_context.dart';
import '../core/api/component_event.dart';
import '../core/api/component_id.dart';
import '../core/api/component_manager.dart';
import '../core/api/component_type.dart';
import '../core/components/component_types.dart';
import '../core/components/fields/field.dart';
import '../core/api/component.dart';

/// Mock SDK Engine for testing and development.
class MockSdkEngine implements ConstellationSdkEngine {
  late ConstellationSdkConfig _config;
  late EngineEventHandler _handler;

  @override
  void configure(ConstellationSdkConfig config, EngineEventHandler handler) {
    _config = config;
    _handler = handler;
  }

  @override
  void performAction(ConstellationSdkAction action) {
    _handler(const LoadingEvent());
    _configureComponents(_config.componentManager);
    _handler(ReadyEvent(const EnvironmentInfo(locale: 'en-US', timeZone: 'America/New_York')));
  }

  void _configureComponents(ComponentManager manager) {
    _component(manager, 10, ComponentTypes.textInput, props: {
      'label': 'First Name',
      'value': '',
      'visible': true,
    });
    _component(manager, 11, ComponentTypes.textInput, props: {
      'label': 'Last Name',
      'value': '',
      'visible': true,
    });
    _component(manager, 12, ComponentTypes.email, props: {
      'label': 'Email',
      'value': '',
      'required': 'true',
      'visible': true,
    });
    _component(manager, 13, ComponentTypes.textArea, props: {
      'label': 'Notes',
      'value': '',
      'visible': true,
      'maxLength': '500',
    });
    _component(manager, 4, ComponentTypes.defaultForm, props: {
      'instructions': 'Please fill out the form below',
      'children': ['10', '11', '12', '13'],
    });

    _component(manager, 31, ComponentTypes.actionButtons, onComponentEvent: _onFillForm, props: {
      'mainButtons': [
        {'type': 'submit', 'name': 'Fill the form', 'jsAction': 'submit'},
      ],
      'secondaryButtons': [],
    });

    _component(manager, 3, ComponentTypes.assignmentCard, props: {
      'loading': false,
      'actionButtons': '31',
      'children': ['4'],
    });
    _component(manager, 2, ComponentTypes.viewContainer, props: {
      'children': ['3'],
    });
    _component(manager, 1, ComponentTypes.rootContainer, props: {
      'viewContainer': '2',
      'modalViewContainer': '',
      'httpMessages': [],
    });
  }

  void _onFillForm(ComponentEvent event) {
    final manager = _config.componentManager;
    final i = Random().nextInt(10000);

    _updateComponent(manager, 10, {
      'label': 'First Name #$i',
      'value': 'Jan #$i',
      'visible': true,
    });
    _updateComponent(manager, 11, {
      'label': 'Last Name #$i',
      'value': 'Kowalski #$i',
      'visible': true,
    });
    _updateComponent(manager, 12, {
      'label': 'Email #$i',
      'value': 'jan.kowalski$i@email.com',
      'visible': true,
    });
    _updateComponent(manager, 13, {
      'label': 'Notes #$i',
      'value': 'Random notes #$i',
      'visible': true,
      'maxLength': '500',
    });
  }

  void _component(
    ComponentManager manager,
    int id,
    ComponentType type, {
    required Map<String, dynamic> props,
    void Function(ComponentEvent)? onComponentEvent,
  }) {
    final context = ComponentContextImpl(
      id: ComponentId(id),
      type: type,
      componentManager: manager,
      onComponentEvent: onComponentEvent ?? (_) {},
    );
    final component = manager.addComponent(context);
    component.addObserver(ComponentObserverCallback(() {
      final value = component is FieldComponent ? component.value : '';
      print('Component updated: $component $value');
    }));
    manager.updateComponent(ComponentId(id), props);
  }

  void _updateComponent(
    ComponentManager manager,
    int id,
    Map<String, dynamic> props,
  ) {
    manager.updateComponent(ComponentId(id), props);
  }
}
