import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_event.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';

/// Display mode for SimpleTableManual.
enum SimpleTableDisplayMode {
  displayOnly,
  editableInModal,
  editableInRow;

  factory SimpleTableDisplayMode.fromString(String value) {
    switch (value) {
      case 'DISPLAY_ONLY':
        return SimpleTableDisplayMode.displayOnly;
      case 'EDITABLE_IN_MODAL':
        return SimpleTableDisplayMode.editableInModal;
      case 'EDITABLE_IN_ROW':
        return SimpleTableDisplayMode.editableInRow;
      default:
        return SimpleTableDisplayMode.displayOnly;
    }
  }
}

/// Cell in a SimpleTableManual row.
class SimpleTableCell {
  final Component component;

  const SimpleTableCell({required this.component});
}

/// Row in a SimpleTableManual.
class SimpleTableRow {
  final List<SimpleTableCell> cells;
  final bool showEditButton;
  final bool showDeleteButton;

  const SimpleTableRow({
    required this.cells,
    required this.showEditButton,
    required this.showDeleteButton,
  });
}

/// Simple table manual component.
class SimpleTableManualComponent extends BaseComponent implements HideableComponent {
  @override
  bool _visible = false;
  String _label = '';
  SimpleTableDisplayMode _displayMode = SimpleTableDisplayMode.displayOnly;
  bool _allowAddRows = true;
  bool _allowReorderRows = true;
  String _addButtonLabel = '';
  List<String> _columnNames = [];
  List<SimpleTableRow> _rows = [];

  SimpleTableManualComponent(ComponentContext context) : super(context);

  @override
  bool get visible => _visible;
  String get label => _label;
  SimpleTableDisplayMode get displayMode => _displayMode;
  bool get allowAddRows => _allowAddRows;
  bool get allowReorderRows => _allowReorderRows;
  String get addButtonLabel => _addButtonLabel;
  List<String> get columnNames => _columnNames;
  List<SimpleTableRow> get rows => _rows;

  @override
  void applyProps(Map<String, dynamic> props) {
    _visible = getBoolean(props, 'visible');
    _label = getString(props, 'label');
    _displayMode = SimpleTableDisplayMode.fromString(getString(props, 'displayMode'));
    _allowAddRows = getBoolean(props, 'allowAddRows');
    _allowReorderRows = getBoolean(props, 'allowReorderRows');
    _addButtonLabel = getString(props, 'addButtonLabel');
    _columnNames = _getColumnNames(props);
    _rows = _getRows(props);
  }

  List<String> _getColumnNames(Map<String, dynamic> props) {
    final columnsArray = getJSONArray(props, 'columnLabels');
    return List.generate(columnsArray.length, (index) => getStringFromArray(columnsArray, index));
  }

  List<SimpleTableRow> _getRows(Map<String, dynamic> props) {
    return getJSONArray(props, 'rows').map((jsonElement) {
      final rowJson = jsonElement as Map<String, dynamic>;
      final componentIds = getJSONArray(rowJson, 'cellComponentIds');
      final ids = <int>[];
      for (int index = 0; index < componentIds.length; index++) {
        final idStr = getStringFromArray(componentIds, index);
        final id = int.tryParse(idStr);
        if (id != null) {
          ids.add(id);
        }
      }
      final cellComponents = context.componentManager.getComponentsByIds(
        ids.map((id) => ComponentId(id)).toList(),
      );
      return SimpleTableRow(
        cells: cellComponents.map((c) => SimpleTableCell(component: c)).toList(),
        showEditButton: getBoolean(rowJson, 'showEditButton'),
        showDeleteButton: getBoolean(rowJson, 'showDeleteButton'),
      );
    }).toList();
  }

  /// Adds a new row.
  void addRow() {
    context.sendComponentEvent(_addRowEvent());
  }

  /// Deletes a row by ID.
  void deleteRow(int rowId) {
    context.sendComponentEvent(_deleteRowEvent(rowId));
  }

  /// Reorders rows.
  void reorderRow(int fromIndex, int toIndex) {
    context.sendComponentEvent(_reorderRowEvent(fromIndex, toIndex));
  }

  /// Opens a row for editing in a modal.
  void editRowInModal(int rowId) {
    context.sendComponentEvent(_editRowInModalEvent(rowId));
  }

  /// Opens modal to add a new row.
  void addRowInModal() {
    context.sendComponentEvent(_addRowInModalEvent());
  }

  ComponentEvent _addRowEvent() => const ComponentEvent(
    type: 'SimpleTableManualEvent',
    eventData: {'type': 'addRow'},
  );

  ComponentEvent _deleteRowEvent(int itemId) => ComponentEvent(
    type: 'SimpleTableManualEvent',
    eventData: {'type': 'deleteRow', 'rowId': itemId.toString()},
  );

  ComponentEvent _reorderRowEvent(int fromIndex, int toIndex) => ComponentEvent(
    type: 'SimpleTableManualEvent',
    eventData: {
      'type': 'reorderRow',
      'fromIndex': fromIndex.toString(),
      'toIndex': toIndex.toString(),
    },
  );

  ComponentEvent _editRowInModalEvent(int rowId) => ComponentEvent(
    type: 'SimpleTableManualEvent',
    eventData: {'type': 'editRowInModal', 'rowId': rowId.toString()},
  );

  ComponentEvent _addRowInModalEvent() => const ComponentEvent(
    type: 'SimpleTableManualEvent',
    eventData: {'type': 'addRowInModal'},
  );
}
