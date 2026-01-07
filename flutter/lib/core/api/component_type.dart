/// Represents the type of a component.
class ComponentType {
  /// The string value of the component's type.
  final String type;

  const ComponentType(this.type);

  @override
  String toString() => type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentType &&
          runtimeType == other.runtimeType &&
          type == other.type;

  @override
  int get hashCode => type.hashCode;
}
