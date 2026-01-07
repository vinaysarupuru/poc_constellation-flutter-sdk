import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_event.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';

/// Field group template item.
class FieldGroupItem {
  final int id;
  final String heading;
  final Component component;
  final bool allowDelete;

  const FieldGroupItem({
    required this.id,
    required this.heading,
    required this.component,
    required this.allowDelete,
  });
}

/// Field group template component.
class FieldGroupTemplateComponent extends BaseComponent {
  List<FieldGroupItem> _items = [];
  bool _allowAddItems = false;
  String _addButtonLabel = '';

  FieldGroupTemplateComponent(ComponentContext context) : super(context);

  List<FieldGroupItem> get items => _items;
  bool get allowAddItems => _allowAddItems;
  String get addButtonLabel => _addButtonLabel;

  @override
  void applyProps(Map<String, dynamic> props) {
    final itemsArray = getJSONArray(props, 'items');
    _items = itemsArray.map((itemJson) {
      final item = itemJson as Map<String, dynamic>;
      final componentId = getString(item, 'componentId');
      final component = context.componentManager.getComponent(ComponentId(int.parse(componentId)));
      if (component == null) return null;
      return FieldGroupItem(
        id: getInt(item, 'id'),
        heading: getString(item, 'heading'),
        component: component,
        allowDelete: getBoolean(item, 'allowDelete'),
      );
    }).whereType<FieldGroupItem>().toList();

    _allowAddItems = getBoolean(props, 'allowAddItems');
    _addButtonLabel = getString(props, 'addButtonLabel');
  }

  /// Adds a new item.
  void addItem() {
    context.sendComponentEvent(_fieldGroupAddItemEvent());
  }

  /// Deletes an item.
  void deleteItem(FieldGroupItem item) {
    context.sendComponentEvent(_fieldGroupDeleteItemEvent(item.id));
  }

  ComponentEvent _fieldGroupAddItemEvent() => const ComponentEvent(
    type: 'FieldGroupTemplateEvent',
    eventData: {'type': 'addItem'},
  );

  ComponentEvent _fieldGroupDeleteItemEvent(int itemId) => ComponentEvent(
    type: 'FieldGroupTemplateEvent',
    eventData: {'type': 'deleteItem', 'itemId': itemId.toString()},
  );
}
