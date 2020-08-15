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

// class CmsEpic {
//   CmsEpic(this._restService, this._cmsRepository);

//   @Inject(mode: InjectMode.singleton)
//   final RestService _restService;

//   @Inject()
//   final CmsRepository _cmsRepository;

//   RestService get rest => _restService;

//   Stream getCmsConfig(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
//     return stream
//         .where((action) => action.name == CmsActionsNames.getRemoteConfig.name)
//         .debounceTime(const Duration(seconds: 1))
//         .switchMap(
//           (action) => _cmsRepository.fetchConfigModel(),
//         )
//         .where((data) => data != null)
//         .doOnData((RemoteConfigModel model) async {
//       if (model.error != null) {
//         api.actions.cmsActions.setRemoteConfig(RemoteConfigModel.createEmptyModelWithError(model.error));
//       } else {
//         final bool useCleanWebsockets = store.state.configState.localSettings.cleanWebsockets;

//         final mockedRemoteConfigModel = model.rebuild((b) => b
//           ..system.cleanWebsocket = useCleanWebsockets || (b.system.cleanWebsocket ?? false)
//           ..lineMinNumber ??= LineMinNumber.defaultLineMinNumber.toBuilder());
//         api.actions.cmsActions.setRemoteConfig(mockedRemoteConfigModel);
//       }
//     }).handleError((error) {
//       api.actions.cmsActions.setRemoteConfig(
//         RemoteConfigModel.createEmptyModelWithError(
//           ErrorModel(
//             (builder) =>
//                 builder..message = error is ClientException ? strings.networkErrorText : strings.commonErrorText,
//           ),
//         ),
//       );
//     });
//   }
// }
