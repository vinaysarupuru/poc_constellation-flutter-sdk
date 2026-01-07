import '../api/component_type.dart';

/// Object that holds all known component types.
class ComponentTypes {
  ComponentTypes._();

  // containers
  static const assignment = ComponentType('Assignment');
  static const assignmentCard = ComponentType('AssignmentCard');
  static const dataReference = ComponentType('DataReference');
  static const defaultForm = ComponentType('DefaultForm');
  static const flowContainer = ComponentType('FlowContainer');
  static const group = ComponentType('Group');
  static const listView = ComponentType('ListView');
  static const modalViewContainer = ComponentType('ModalViewContainer');
  static const oneColumn = ComponentType('OneColumn');
  static const region = ComponentType('Region');
  static const rootContainer = ComponentType('RootContainer');
  static const view = ComponentType('View');
  static const viewContainer = ComponentType('ViewContainer');

  // templates
  static const simpleTable = ComponentType('SimpleTable');
  static const simpleTableManual = ComponentType('SimpleTableManual');
  static const simpleTableSelect = ComponentType('SimpleTableSelect');
  static const fieldGroupTemplate = ComponentType('FieldGroupTemplate');

  // fields
  static const checkbox = ComponentType('Checkbox');
  static const currency = ComponentType('Currency');
  static const date = ComponentType('Date');
  static const dateTime = ComponentType('DateTime');
  static const decimal = ComponentType('Decimal');
  static const dropdown = ComponentType('Dropdown');
  static const email = ComponentType('Email');
  static const integer = ComponentType('Integer');
  static const phone = ComponentType('Phone');
  static const radioButtons = ComponentType('RadioButtons');
  static const textArea = ComponentType('TextArea');
  static const textInput = ComponentType('TextInput');
  static const time = ComponentType('Time');
  static const url = ComponentType('URL');

  // widgets
  static const actionButtons = ComponentType('ActionButtons');
  static const alertBanner = ComponentType('AlertBanner');

  // unsupported
  static const unsupported = ComponentType('Unsupported');
}
