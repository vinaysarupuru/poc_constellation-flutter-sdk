/// Represents a unique identifier for a component.
class ComponentId {
  /// The integer value of the component's identifier.
  final int id;

  const ComponentId(this.id);

  @override
  String toString() => '#$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentId &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
