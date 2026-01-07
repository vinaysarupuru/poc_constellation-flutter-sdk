import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';
import '../widgets/alert_banner.dart';
import 'assignment.dart';

/// Flow container component.
class FlowContainerComponent extends BaseComponent {
  String _title = '';
  AssignmentComponent? _assignment;
  List<AlertBannerComponent> _alertBanners = [];

  FlowContainerComponent(ComponentContext context) : super(context);

  String get title => _title;
  AssignmentComponent? get assignment => _assignment;
  List<AlertBannerComponent> get alertBanners => _alertBanners;

  @override
  void applyProps(Map<String, dynamic> props) {
    final manager = context.componentManager;
    final assignmentId = ComponentId(int.parse(getString(props, 'assignment')));
    final banners = getJSONArray(props, 'alertBanners');
    final bannersIds = List.generate(banners.length, (index) {
      return int.parse(getStringFromArray(banners, index));
    });

    _title = getString(props, 'title');
    _assignment = manager.getComponent(assignmentId) as AssignmentComponent?;
    _alertBanners = bannersIds
        .map((id) => manager.getComponent(ComponentId(id)))
        .whereType<AlertBannerComponent>()
        .toList();
  }
}
