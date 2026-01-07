import 'component_type.dart';
import 'component_script.dart';
import 'component_producer.dart';

/// Class which defines a component.
///
/// [type] type of the component. It can be built-in type or custom type.
/// [script] (optional) script to be injected for the component.
/// [producer] function which takes component context and returns new Component
class ComponentDefinition {
  final ComponentType type;
  final ComponentScript? script;
  final ComponentProducer producer;

  const ComponentDefinition({
    required this.type,
    this.script,
    required this.producer,
  });
}
