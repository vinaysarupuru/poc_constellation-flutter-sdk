import '../api/component_definition.dart';
import 'component_types.dart';

// Field components
import 'fields/text_input.dart';
import 'fields/text_area.dart';
import 'fields/email.dart';
import 'fields/url.dart';
import 'fields/integer.dart';
import 'fields/decimal.dart';
import 'fields/currency.dart';
import 'fields/checkbox.dart';
import 'fields/dropdown.dart';
import 'fields/radio_buttons.dart';
import 'fields/date.dart';
import 'fields/time.dart';
import 'fields/date_time.dart';
import 'fields/phone.dart';

// Container components
import 'containers/root_container.dart';
import 'containers/view_container.dart';
import 'containers/view.dart';
import 'containers/assignment.dart';
import 'containers/assignment_card.dart';
import 'containers/flow_container.dart';
import 'containers/default_form.dart';
import 'containers/region.dart';
import 'containers/one_column.dart';
import 'containers/group.dart';
import 'containers/data_reference.dart';
import 'containers/modal_view_container.dart';
import 'containers/list_view_component.dart';
import 'containers/field_group_template.dart';
import 'containers/simple_table.dart';
import 'containers/simple_table_manual.dart';
import 'containers/simple_table_select.dart';

// Widget components
import 'widgets/action_buttons.dart';
import 'widgets/alert_banner.dart';
import 'widgets/unsupported.dart';

/// Registry of all supported components.
class ComponentRegistry {
  ComponentRegistry._();

  /// Supported component definitions.
  static final List<ComponentDefinition> defaultDefinitions = [
    // Widgets
    ComponentDefinition(
      type: ComponentTypes.actionButtons,
      producer: (context) => ActionButtonsComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.alertBanner,
      producer: (context) => AlertBannerComponent(context),
    ),
    // Containers
    ComponentDefinition(
      type: ComponentTypes.assignment,
      producer: (context) => AssignmentComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.assignmentCard,
      producer: (context) => AssignmentCardComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.dataReference,
      producer: (context) => DataReferenceComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.defaultForm,
      producer: (context) => DefaultFormComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.fieldGroupTemplate,
      producer: (context) => FieldGroupTemplateComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.flowContainer,
      producer: (context) => FlowContainerComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.group,
      producer: (context) => GroupComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.listView,
      producer: (context) => ListViewComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.modalViewContainer,
      producer: (context) => ModalViewContainerComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.oneColumn,
      producer: (context) => OneColumnComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.region,
      producer: (context) => RegionComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.rootContainer,
      producer: (context) => RootContainerComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.simpleTable,
      producer: (context) => SimpleTableComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.simpleTableManual,
      producer: (context) => SimpleTableManualComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.simpleTableSelect,
      producer: (context) => SimpleTableSelectComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.view,
      producer: (context) => ViewComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.viewContainer,
      producer: (context) => ViewContainerComponent(context),
    ),
    // Fields
    ComponentDefinition(
      type: ComponentTypes.checkbox,
      producer: (context) => CheckboxComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.currency,
      producer: (context) => CurrencyComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.date,
      producer: (context) => DateComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.dateTime,
      producer: (context) => DateTimeComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.decimal,
      producer: (context) => DecimalComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.dropdown,
      producer: (context) => DropdownComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.email,
      producer: (context) => EmailComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.integer,
      producer: (context) => IntegerComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.phone,
      producer: (context) => PhoneComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.radioButtons,
      producer: (context) => RadioButtonsComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.textArea,
      producer: (context) => TextAreaComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.textInput,
      producer: (context) => TextInputComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.time,
      producer: (context) => TimeComponent(context),
    ),
    ComponentDefinition(
      type: ComponentTypes.url,
      producer: (context) => UrlComponent(context),
    ),
    // Unsupported
    ComponentDefinition(
      type: ComponentTypes.unsupported,
      producer: (context) => UnsupportedComponent(context),
    ),
  ];
}
