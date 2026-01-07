import '../../api/component.dart';
import '../../api/component_context.dart';
import '../../api/component_id.dart';
import '../json_utils.dart';
import '../widgets/dialog.dart';
import 'view_container.dart';
import 'modal_view_container.dart';

/// Root container component that holds the main view container.
class RootContainerComponent extends BaseComponent {
  ViewContainerComponent? _viewContainer;
  List<String> _httpMessages = [];
  DialogConfig? _dialogConfig;
  ModalViewContainerComponent? _modalViewContainer;

  RootContainerComponent(ComponentContext context) : super(context);

  ViewContainerComponent? get viewContainer => _viewContainer;
  List<String> get httpMessages => _httpMessages;
  DialogConfig? get dialogConfig => _dialogConfig;
  ModalViewContainerComponent? get modalViewContainer => _modalViewContainer;

  /// Presents a dialog.
  void presentDialog(DialogConfig config) {
    _dialogConfig = config;
    notifyObservers();
    notifyListeners();
  }

  /// Dismisses the current dialog.
  void dismissDialog() {
    _dialogConfig = null;
    notifyObservers();
    notifyListeners();
  }

  @override
  void applyProps(Map<String, dynamic> props) {
    final viewContainerId = ComponentId(int.parse(getString(props, 'viewContainer')));
    _viewContainer = context.componentManager.getComponent(viewContainerId) as ViewContainerComponent?;

    // Modal view container is optional
    final modalViewContainerIdStr = optString(props, 'modalViewContainer');
    if (modalViewContainerIdStr.isNotEmpty) {
      final modalViewContainerId = ComponentId(int.parse(modalViewContainerIdStr));
      _modalViewContainer = context.componentManager.getComponent(modalViewContainerId) as ModalViewContainerComponent?;
    }

    final httpMessagesArray = getJSONArray(props, 'httpMessages');
    _httpMessages = List.generate(httpMessagesArray.length, (index) {
      final httpMessage = getJsonObject(httpMessagesArray, index);
      final type = getString(httpMessage, 'type');
      final message = getString(httpMessage, 'message');
      final prefix = type == 'error' ? 'Http error: ' : '';
      return prefix + message;
    });
  }

  /// Clears all HTTP messages.
  void clearMessages() {
    _httpMessages = [];
    notifyListeners();
  }
}
