import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';

/// Base class for container components that hold child components.
abstract class ContainerComponent extends BaseComponent {
  List<Component> _children = [];

  ContainerComponent(super.context);

  List<Component> get children => _children;

  @override
  void applyProps(Map<String, dynamic> props) {
    _children = _getChildren(props);
  }

  List<Component> _getChildren(Map<String, dynamic> props) {
    final childrenArray = getJSONArray(props, 'children');
    final ids = List.generate(childrenArray.length, (index) {
      return int.parse(getStringFromArray(childrenArray, index));
    });
    return context.componentManager.getComponentsByIds(
      ids.map((id) => ComponentId(id)).toList(),
    );
  }
}
