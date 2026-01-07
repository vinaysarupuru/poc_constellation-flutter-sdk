import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_event.dart';
import '../../api/component_id.dart';
import '../../log.dart';
import '../json_utils.dart';

/// Selection mode for ListView.
enum ListViewSelectionMode { single, multi }

/// Data class for ListView items.
class ListViewItem {
  final Map<String, String> data;

  const ListViewItem({required this.data});
}

/// ListView component.
class ListViewComponent extends BaseComponent {
  static const String _tag = 'ListViewComponent';
  static const String _selectSingleItemEvent = 'SelectSingleItem';

  String _label = '';
  ListViewSelectionMode _selectionMode = ListViewSelectionMode.single;
  int? _selectedItemIndex;
  List<String> _columnNames = [];
  List<String> _columnLabels = [];
  List<ListViewItem> _items = [];

  ListViewComponent(ComponentContext context) : super(context);

  String get label => _label;
  ListViewSelectionMode get selectionMode => _selectionMode;
  int? get selectedItemIndex => _selectedItemIndex;
  List<String> get columnNames => _columnNames;
  List<String> get columnLabels => _columnLabels;
  List<ListViewItem> get items => _items;

  @override
  void applyProps(Map<String, dynamic> props) {
    _label = getString(props, 'label');

    final modeStr = getString(props, 'selectionMode');
    if (modeStr.toUpperCase() != 'SINGLE') {
      Log.w(_tag, 'Only SINGLE selection mode is supported. Defaulting to SINGLE.');
    }
    _selectionMode = ListViewSelectionMode.single;

    final selectedIndexStr = optString(props, 'selectedItemIndex');
    _selectedItemIndex = selectedIndexStr.isNotEmpty ? int.tryParse(selectedIndexStr) : null;

    _columnNames = getJSONArray(props, 'columnNames').map((e) => e.toString()).toList();
    _columnLabels = getJSONArray(props, 'columnLabels').map((e) => e.toString()).toList();

    _items = getJSONArray(props, 'items').map((e) {
      return ListViewItem(data: _toFoldedItemContent(e, {}, ''));
    }).toList();
  }

  /// Selects an item by index.
  void onItemSelected(int itemIndex) {
    _selectedItemIndex = itemIndex;
    context.sendComponentEvent(_itemSelectedEvent(itemIndex));
    notifyListeners();
  }

  ComponentEvent _itemSelectedEvent(int itemIndex) => ComponentEvent(
    type: _selectSingleItemEvent,
    componentData: {'selectedItemIndex': itemIndex.toString()},
  );

  Map<String, String> _toFoldedItemContent(
    dynamic element,
    Map<String, String> initialResult,
    String currentPath,
  ) {
    if (element is Map) {
      Map<String, String> result = Map.from(initialResult);
      for (final entry in element.entries) {
        final nextPath = currentPath.isNotEmpty ? '$currentPath.${entry.key}' : entry.key.toString();
        result = _toFoldedItemContent(entry.value, result, nextPath);
      }
      return result;
    } else if (element is List) {
      Map<String, String> result = Map.from(initialResult);
      for (int i = 0; i < element.length; i++) {
        result = _toFoldedItemContent(element[i], result, '$currentPath[$i]');
      }
      return result;
    } else {
      return {...initialResult, currentPath: element.toString()};
    }
  }
}
