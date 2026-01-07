import 'component.dart';
import 'component_context.dart';

/// Functional interface for producing components based on their context.
typedef ComponentProducer = Component Function(ComponentContext context);
