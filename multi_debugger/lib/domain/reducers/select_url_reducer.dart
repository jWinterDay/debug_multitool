import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/saved_url_actions.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';

NestedReducerBuilder<AppState, AppStateBuilder, SavedUrlState, SavedUrlStateBuilder> createSelectUrlReducer() =>
    NestedReducerBuilder<AppState, AppStateBuilder, SavedUrlState, SavedUrlStateBuilder>(
      (state) => state.savedUrlState,
      (builder) => builder.savedUrlState,
    )
      ..add<SavedUrl>(SavedUrlActionsNames.addUrl, _addUrl)
      ..add<Iterable<SavedUrl>>(SavedUrlActionsNames.addAllUrl, _addAllUrl)
      ..add<SavedUrl>(SavedUrlActionsNames.deleteUrl, _deleteUrl);

void _addUrl(SavedUrlState state, Action<SavedUrl> action, SavedUrlStateBuilder builder) {
  final SavedUrl savedUrl = action.payload;

  builder.urls.putIfAbsent(savedUrl.savedUrlId, () => savedUrl);
}

void _addAllUrl(SavedUrlState state, Action<Iterable<SavedUrl>> action, SavedUrlStateBuilder builder) {
  final Iterable<SavedUrl> savedUrlList = action.payload;

  final Map<String, SavedUrl> savedUrlAsMap = {
    for (SavedUrl savedUrl in savedUrlList) (savedUrl).savedUrlId: savedUrl,
  };

  builder.urls.addAll(savedUrlAsMap);
}

void _deleteUrl(SavedUrlState state, Action<SavedUrl> action, SavedUrlStateBuilder builder) {
  final SavedUrl savedUrl = action.payload;

  if (!savedUrl.custom) {
    return;
  }

  // channel list
  builder.urls.remove(savedUrl.savedUrlId);
}
