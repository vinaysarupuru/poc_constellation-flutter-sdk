import 'package:flutter/material.dart';
import '../core/api/component.dart';
import '../core/api/component_type.dart';
import '../core/environment_info.dart';
import '../core/components/component_types.dart';
import '../core/components/widgets/unsupported.dart';
import '../core/log.dart';

// Import all renderers
import 'fields/text_input_renderer.dart';
import 'fields/text_area_renderer.dart';
import 'fields/email_renderer.dart';
import 'fields/url_renderer.dart';
import 'fields/integer_renderer.dart';
import 'fields/decimal_renderer.dart';
import 'fields/currency_renderer.dart';
import 'fields/checkbox_renderer.dart';
import 'fields/dropdown_renderer.dart';
import 'fields/radio_buttons_renderer.dart';
import 'fields/date_renderer.dart';
import 'fields/time_renderer.dart';
import 'fields/date_time_renderer.dart';
import 'fields/phone_renderer.dart';
import 'containers/root_container_renderer.dart';
import 'containers/view_container_renderer.dart';
import 'containers/view_renderer.dart';
import 'containers/assignment_renderer.dart';
import 'containers/assignment_card_renderer.dart';
import 'containers/flow_container_renderer.dart';
import 'containers/default_form_renderer.dart';
import 'containers/region_renderer.dart';
import 'containers/one_column_renderer.dart';
import 'containers/group_renderer.dart';
import 'containers/data_reference_renderer.dart';
import 'containers/modal_view_container_renderer.dart';
import 'containers/list_view_renderer.dart';
import 'containers/field_group_template_renderer.dart';
import 'containers/simple_table_renderer.dart';
import 'containers/simple_table_manual_renderer.dart';
import 'containers/simple_table_select_renderer.dart';
import 'widgets/action_buttons_renderer.dart';
import 'widgets/alert_banner_renderer.dart';
import 'widgets/unsupported_renderer.dart';

const String _tag = 'ComponentRenderer';

/// Interface for component renderers.
abstract class ComponentRenderer<C extends Component> {
  Widget render(C component);
}

/// Context for rendering components.
class RenderContext extends InheritedWidget {
  final Map<ComponentType, ComponentRenderer<dynamic>> renderers;
  final EnvironmentInfo environmentInfo;

  const RenderContext({
    super.key,
    required this.renderers,
    required this.environmentInfo,
    required super.child,
  });

  static RenderContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RenderContext>();
  }

  @override
  bool updateShouldNotify(RenderContext oldWidget) {
    return renderers != oldWidget.renderers ||
        environmentInfo != oldWidget.environmentInfo;
  }
}

/// Helper function to render a component.
Widget renderComponent(BuildContext context, Component component) {
  final renderContext = RenderContext.of(context);
  if (renderContext == null) {
    Log.e(_tag, 'RenderContext not found');
    return const SizedBox.shrink();
  }

  final renderers = renderContext.renderers;
  final renderer = renderers[component.context.type];

  if (renderer != null) {
    try {
      return renderer.render(component);
    } catch (e) {
      Log.e(_tag, 'Component rendering failed: $component', e);
      return const SizedBox.shrink();
    }
  }

  // Use unsupported renderer as fallback
  final unsupportedRenderer = renderers[ComponentTypes.unsupported];
  if (unsupportedRenderer != null) {
    final unsupported = UnsupportedComponent.create(
      component.context,
      cause: UnsupportedCause.missingComponentRenderer,
    );
    Log.e(_tag, 'Cannot find component renderer for ${component.context.type}');
    return unsupportedRenderer.render(unsupported);
  }

  return const SizedBox.shrink();
}

/// Provider widget for component renderers.
class ComponentRendererProvider extends StatelessWidget {
  final Map<ComponentType, ComponentRenderer<dynamic>>? customRenderers;
  final EnvironmentInfo environmentInfo;
  final Widget child;

  const ComponentRendererProvider({
    super.key,
    this.customRenderers,
    required this.environmentInfo,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final renderers = {
      ...ComponentRenderers.defaultRenderers,
      if (customRenderers != null) ...customRenderers!,
    };

    return RenderContext(
      renderers: renderers,
      environmentInfo: environmentInfo,
      child: child,
    );
  }
}

/// Registry of default component renderers.
class ComponentRenderers {
  ComponentRenderers._();

  static final Map<ComponentType, ComponentRenderer<dynamic>> defaultRenderers = {
    // Fields
    ComponentTypes.textInput: TextInputRenderer(),
    ComponentTypes.textArea: TextAreaRenderer(),
    ComponentTypes.email: EmailRenderer(),
    ComponentTypes.url: UrlRenderer(),
    ComponentTypes.integer: IntegerRenderer(),
    ComponentTypes.decimal: DecimalRenderer(),
    ComponentTypes.currency: CurrencyRenderer(),
    ComponentTypes.checkbox: CheckboxRenderer(),
    ComponentTypes.dropdown: DropdownRenderer(),
    ComponentTypes.radioButtons: RadioButtonsRenderer(),
    ComponentTypes.date: DateRenderer(),
    ComponentTypes.time: TimeRenderer(),
    ComponentTypes.dateTime: DateTimeRenderer(),
    ComponentTypes.phone: PhoneRenderer(),
    // Containers
    ComponentTypes.rootContainer: RootContainerRenderer(),
    ComponentTypes.viewContainer: ViewContainerRenderer(),
    ComponentTypes.view: ViewRenderer(),
    ComponentTypes.assignment: AssignmentRenderer(),
    ComponentTypes.assignmentCard: AssignmentCardRenderer(),
    ComponentTypes.flowContainer: FlowContainerRenderer(),
    ComponentTypes.defaultForm: DefaultFormRenderer(),
    ComponentTypes.region: RegionRenderer(),
    ComponentTypes.oneColumn: OneColumnRenderer(),
    ComponentTypes.group: GroupRenderer(),
    ComponentTypes.dataReference: DataReferenceRenderer(),
    ComponentTypes.modalViewContainer: ModalViewContainerRenderer(),
    ComponentTypes.listView: ListViewRenderer(),
    ComponentTypes.fieldGroupTemplate: FieldGroupTemplateRenderer(),
    ComponentTypes.simpleTable: SimpleTableRenderer(),
    ComponentTypes.simpleTableManual: SimpleTableManualRenderer(),
    ComponentTypes.simpleTableSelect: SimpleTableSelectRenderer(),
    // Widgets
    ComponentTypes.actionButtons: ActionButtonsRenderer(),
    ComponentTypes.alertBanner: AlertBannerRenderer(),
    ComponentTypes.unsupported: UnsupportedRenderer(),
  };
}
