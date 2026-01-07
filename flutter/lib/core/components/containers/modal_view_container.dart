import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_event.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';
import '../widgets/alert_banner.dart';
import 'container.dart';

/// Modal view container component.
class ModalViewContainerComponent extends ContainerComponent implements HideableComponent {
  @override
  bool _visible = false;
  String _title = '';
  String _cancelButtonLabel = '';
  String _submitButtonLabel = '';
  List<AlertBannerComponent> _alertBanners = [];

  ModalViewContainerComponent(ComponentContext context) : super(context);

  @override
  bool get visible => _visible;
  String get title => _title;
  String get cancelButtonLabel => _cancelButtonLabel;
  String get submitButtonLabel => _submitButtonLabel;
  List<AlertBannerComponent> get alertBanners => _alertBanners;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _visible = getBoolean(props, 'visible');
    _title = getString(props, 'title');
    _cancelButtonLabel = getString(props, 'cancelLabel');
    _submitButtonLabel = getString(props, 'submitLabel');

    final banners = getJSONArray(props, 'alertBanners');
    final bannersIds = List.generate(banners.length, (index) {
      return int.parse(getStringFromArray(banners, index));
    });
    _alertBanners = bannersIds
        .map((id) => context.componentManager.getComponent(ComponentId(id)))
        .whereType<AlertBannerComponent>()
        .toList();
  }

  /// Called when cancel button is clicked.
  void onCancelClick() {
    context.sendComponentEvent(_cancelEvent());
  }

  /// Called when submit button is clicked.
  void onSubmitClick() {
    context.sendComponentEvent(_submitEvent());
  }

  ComponentEvent _cancelEvent() => const ComponentEvent(
    type: 'ModalViewContainerEvent',
    eventData: {'type': 'cancel'},
  );

  ComponentEvent _submitEvent() => const ComponentEvent(
    type: 'ModalViewContainerEvent',
    eventData: {'type': 'submit'},
  );
}
