// import 'package:built_redux/built_redux.dart';
// import 'package:dioc/dioc.dart';
// import 'package:http/http.dart';
// import 'package:ligastavok/app/globals.dart';
// import 'package:ligastavok/domain/actions/actions.dart';
// import 'package:ligastavok/domain/actions/cms_actions.dart';
// import 'package:ligastavok/domain/models/common/error_model.dart';
// import 'package:ligastavok/domain/models/config/remote_config_model.dart';
// import 'package:ligastavok/domain/models/line_min_number.dart';
// import 'package:ligastavok/domain/network/service/rest_service.dart';
// import 'package:ligastavok/domain/states/application.dart';
// import 'package:ligastavok/repository/cms/cms_repository.dart';
// import 'package:rxdart/rxdart.dart';

import 'package:built_redux/built_redux.dart';
import 'package:multi_debugger/domain/actions/actions.dart';
import 'package:multi_debugger/domain/models/app_state.dart';

class RemoteEpic {
  Stream fetchRemoteConfig(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return null;
    //   return stream
    //       // .where((action) => action.name == CmsActionsNames.getRemoteConfig.name)
    //       // .debounceTime(const Duration(seconds: 1))
    //       // .switchMap(
    //       //   (action) => _cmsRepository.fetchConfigModel(),
    //       // )
    //       // .where((data) => data != null)
    //       .doOnData((dynamic model) async {})
    //       .handleError((dynamic error) {});
  }
}
