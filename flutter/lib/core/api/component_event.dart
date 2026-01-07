/// Data for event sent to SDK engine.
///
/// [type] - event type. Supported by default components are: 'FieldChange', 'FieldChangeWithFocus'.
/// Other types can be supported for custom components added by user.
/// [componentData] - component data like 'value'
/// [eventData] - data of event. e.g.: for 'FieldChangeWithFocus' we should add 'focused' with value
class ComponentEvent {
  static const String _fieldChange = 'FieldChange';
  static const String _fieldChangeWithFocus = 'FieldChangeWithFocus';
  static const String _actionButtonClick = 'ActionButtonClick';

  final String type;
  final Map<String, String> componentData;
  final Map<String, String> eventData;

  const ComponentEvent({
    required this.type,
    this.componentData = const {},
    this.eventData = const {},
  });

  /// Encodes the event to a JSON string.
  String encodeToJsonString() {
    return '{"type":"$type","componentData":${_mapToJsonString(componentData)},"eventData":${_mapToJsonString(eventData)}}';
  }

  String _mapToJsonString(Map<String, String> map) {
    final entries = map.entries.map((e) => '"${e.key}":"${e.value}"').join(',');
    return '{$entries}';
  }

  /// Creates a FieldChange event.
  factory ComponentEvent.forFieldChange(String value) {
    return ComponentEvent(
      type: _fieldChange,
      componentData: {'value': value},
    );
  }

  /// Creates a FieldChangeWithFocus event.
  factory ComponentEvent.forFieldChangeWithFocus(String value, bool focused) {
    return ComponentEvent(
      type: _fieldChangeWithFocus,
      componentData: {'value': value},
      eventData: {'focused': focused.toString()},
    );
  }

  /// Creates an ActionButtonClick event.
  factory ComponentEvent.forActionButtonClick(String buttonType, String jsAction) {
    return ComponentEvent(
      type: _actionButtonClick,
      componentData: {
        'buttonType': buttonType,
        'jsAction': jsAction,
      },
    );
  }
}
