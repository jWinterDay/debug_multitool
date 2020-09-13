import 'package:multi_debugger/domain/actions/saved_url_actions.dart';

class SavedUrlSelectors {
  /// actions to save saved urls
  static List<String> actionNames = [
    SavedUrlActionsNames.addUrl.name,
    SavedUrlActionsNames.deleteUrl.name,
  ];
}
