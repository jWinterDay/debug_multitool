// import 'package:built_redux/built_redux.dart';
// import 'package:flutter/foundation.dart';
// import 'package:ligastavok/app/globals.dart' as globals;
// import 'package:ligastavok/domain/actions/actions.dart';
// import 'package:ligastavok/domain/built_redux_rx.dart';
// import 'package:ligastavok/domain/middleware/access_token_middleware.dart';
// import 'package:ligastavok/domain/middleware/archive_middleware.dart';
// import 'package:ligastavok/domain/middleware/bet_middleware.dart';
// import 'package:ligastavok/domain/middleware/cart_middleware.dart';
// import 'package:ligastavok/domain/middleware/dialog_middleware.dart';
// import 'package:ligastavok/domain/middleware/epics/balance/balance_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/epics.dart';
// import 'package:ligastavok/domain/middleware/epics/event_statistics_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/fetch_events_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/firebase_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/live_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/outcome_extend_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/sport_book_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/tokens_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/user_info_epic.dart';
// import 'package:ligastavok/domain/middleware/epics/withdraw/withdraw_epic.dart';
// import 'package:ligastavok/domain/middleware/events_middleware.dart';
// import 'package:ligastavok/domain/middleware/favorites_middleware.dart';
// import 'package:ligastavok/domain/middleware/line_middleware.dart';
// import 'package:ligastavok/domain/middleware/logging_middleware.dart';
// import 'package:ligastavok/domain/middleware/network_config_middleware.dart';
// import 'package:ligastavok/domain/middleware/pin_middleware.dart';
// import 'package:ligastavok/domain/middleware/stage_middleware.dart';
// import 'package:ligastavok/domain/middleware/statusbar_middleware.dart';
// import 'package:ligastavok/domain/middleware/subscription_middleware.dart';
// import 'package:ligastavok/domain/middleware/user_middleware.dart';
// import 'package:ligastavok/domain/middleware/websocket_middleware.dart';
// import 'package:ligastavok/domain/network/service/rest_service.dart';
// import 'package:ligastavok/domain/states/application.dart';
// import 'package:ligastavok/feature/bet/domain/middleware/bet_epic.dart';
// import 'package:ligastavok/feature/deeplink/deeplinks.dart';
// import 'package:ligastavok/feature/documents/domain/middleware/documents_epic.dart';
// import 'package:ligastavok/feature/favorites/redux/middleware/favorite_events_middleware.dart';
// import 'package:ligastavok/feature/identification/redux/middleware/identification_epic.dart';
// import 'package:ligastavok/feature/identification/redux/middleware/identification_middleware.dart';
// import 'package:ligastavok/feature/making_bet_next/domain/middleware/make_bet_epic.dart';
// import 'package:ligastavok/feature/navigation/domain/navigation.dart';
// import 'package:ligastavok/feature/promocode/redux/promocode_epic.dart';
// import 'package:ligastavok/feature/promocode/redux/promocode_middleware.dart';
// import 'package:ligastavok/feature/recharge/domain/middleware/recharge_middleware.dart';
// import 'package:ligastavok/feature/registration/domain/middleware/password_epic.dart';
// import 'package:ligastavok/feature/registration/domain/middleware/registration_epic.dart';
// import 'package:ligastavok/feature/registration/domain/middleware/registration_middleware.dart';
// import 'package:ligastavok/feature/reset_password/domain/middleware/reset_password_middlewares.dart';
// import 'package:ligastavok/feature/search/domain/search_epic.dart';
// import 'package:ligastavok/feature/search/domain/search_middleware.dart';
// import 'package:ligastavok/feature/stories/redux/middleware/stories_middleware.dart';
// import 'package:ligastavok/feature/video_broadcast/video_broadcast.dart';

// import 'alerts_middleware.dart';
// import 'epics/cms_epic.dart';
// import 'event_diffs_middleware.dart';
// import 'event_position_middleware.dart';
// import 'event_repaint_middleware.dart';
// import 'event_statistics_middleware.dart';
// import 'get_balance_middleware.dart';

// const analyticsIsOn = true;
// const storiesIsOn = true;

// final _diContainer = globals.di;

// final _searchEpic = _diContainer.singleton<SearchEpic>();
// final _userInfoEpic = _diContainer.singleton<UserInfoEpic>();
// final _tokenEpic = _diContainer.singleton<TokensEpic>();
// final _fetchEventsEpic = _diContainer.singleton<FetchEventsEpic>();
// final _sportBookEpic = _diContainer.singleton<SportBookEpic>();
// final _liveEpic = _diContainer.singleton<LiveEpic>();
// final _paymentsEpic = _diContainer.singleton<PaymentsEpic>();
// final _extendOutcomeEpic = _diContainer.singleton<OutcomeExtendEpic>();
// final _paymentSystemEpic = _diContainer.singleton<PaymentsSystemEpic>();
// final _betsEpic = _diContainer.singleton<BetsEpic>();
// final _makeBetEpic = _diContainer.singleton<MakeBetEpic>();
// final _authEpic = _diContainer.singleton<AuthEpic>();
// final _registrationEpic = _diContainer.singleton<RegistrationEpic>();
// final _resetPasswordEpic = _diContainer.singleton<ResetPasswordEpic>();
// final _promocodeEpic = _diContainer.singleton<PromocodeEpic>();
// final _identificationEpic = _diContainer.singleton<IdentificationEpic>();
// final _withdrawEpic = _diContainer.singleton<WithdrawEpic>();
// final _balanceEpic = _diContainer.singleton<BalanceEpic>();
// final _cmsEpic = _diContainer.singleton<CmsEpic>();
// final _rechargeEpic = _diContainer.singleton<RechargeEpic>();
// final _favoritesEpic = _diContainer.singleton<FavoriteEventsEpic>();
// final _statisticsEpic = _diContainer.singleton<EventStatisticsEpic>();
// final _passwordEpic = _diContainer.singleton<PasswordEpic>();
// final _documentsEpic = _diContainer.singleton<DocumentsEpic>();
// final _deeplinkEpic = _diContainer.singleton<DeeplinkEpic>();

// void enableRestLogs({bool isEnabled}) {
//   final rest = _diContainer.singleton<RestService>()..setLoggingEnabled(isEnabled: isEnabled);
// }

// Iterable<Middleware<AppState, AppStateBuilder, AppActions>> get middlewares => [
//       if (!kReleaseMode) loggingMiddleware,
//       createStageMiddleware().build(),
//       pinMiddleware().build(),
//       eventPositionMiddleware().build(),
//       eventStatisticsMiddleware().build(),
//       eventRepaintMiddleware().build(),
//       createStatusBarMiddleware().build(),
//       navigationMiddleware().build(),
//       dialogMiddleware().build(),
//       createBetMiddleware().build(),
//       networkConfigMiddleware().build(),
//       createCartMiddleware().build(),
//       webSocketMiddleware().build(),
//       createArchiveMiddleware().build(),
//       createFavoritesMiddleware().build(),
//       createLineMiddleware().build(),
//       createUserMiddleware().build(),
//       // createVideoMiddleware().build(),
//       createRegistrationMiddleware().build(),
//       createPromocodeMiddleware().build(),
//       createEventMiddleware().build(),
//       createEventDiffsMiddleware().build(),
//       subscriptionMiddleware().build(),
//       balanceMiddleware().build(),
//       createAlertsMiddleware().build(),
//       createIdentificationMiddleware().build(),
//       accessTokenMiddleware().build(),
//       createVideoPlayerMiddleware().build(),
//       createSearchMiddleware().build(),
//       //createTwitchExtractorMiddleware().build(),
//       if (storiesIsOn) storiesMiddlewareBuilder().build(),
//       // if (analyticsIsOn) ...[
//       //   analyticsFlurryMiddleware,
//       //   appsFlyerEventsAnalyticsMiddleware().build(),
//       //   if (kReleaseMode) gibAnalyticsMiddleware().build(),
//       //   flurryBetAnalyticsMiddleware().build(),
//       //   flurryRegistrationMiddleware().build(),
//       //   newFlurryRegistrationMiddleware().build(),
//       //   appsFlyerBetAnalyticsMiddleware().build(),
//       //   facebookRegistrationMiddleware().build()
//       // ],
//       createEpicMiddleware(
//         [
//           _statisticsEpic.requestStatistics,
//           _betsEpic.makeBetEpic,
//           _makeBetEpic.checkBet,
//           _makeBetEpic.makeBet,
//           _makeBetEpic.fetchLastUserBet,
//           _authEpic.authEpic,
//           _authEpic.updatePassword,
//           _tokenEpic.refreshTokenWithResumeActionEpic,
//           _tokenEpic.refreshTokenEpic,
//           _tokenEpic.initTokenEpic,
//           _tokenEpic.registerDeviceToken,
//           _userInfoEpic.userInfo,
//           _betsEpic.getBetsHistory,
//           _fetchEventsEpic.fetchEvents,
//           _fetchEventsEpic.fetchFullEvents,
//           _fetchEventsEpic.fetchArchiveEvents,
//           _fetchEventsEpic.fetchTopEvents,
//           _fetchEventsEpic.getPartnerStreamUrl,
//           _resetPasswordEpic.findUser,
//           _resetPasswordEpic.getSecretQuestion,
//           _promocodeEpic.addPromocode,
//           _promocodeEpic.getPromocodeList,
//           _identificationEpic.sendConfirmationEmail,
//           _identificationEpic.reSendConfirmationEmail,
//           _identificationEpic.confirmEmail,
//           _identificationEpic.setPhoneNumberEpic,
//           _identificationEpic.checkPhoneConfirmationEpic,
//           _identificationEpic.sendIdentificationSmsEpic,
//           _identificationEpic.bindAccountEpic,
//           _identificationEpic.sendDocumentsEpic,
//           _identificationEpic.getSimpleIdentityState,
//           _identificationEpic.sendSimpleIdentityDocs,
//           _identificationEpic.sendSimpleIdentityScans,
//           _passwordEpic.resetPassword,
//           _passwordEpic.changePassword,
//           _passwordEpic.requestResetPassword,
//           _searchEpic.search,
//           // _searchEpic.,
//           _paymentsEpic.getPaymentsHistory,
//           _extendOutcomeEpic.extendOutcomeEpic,
//           _sportBookEpic.fetchSportsTree,
//           _sportBookEpic.fetchLeagues,
//           _sportBookEpic.fetchCounters,
//           _sportBookEpic.fetchPeriodTree,
//           _liveEpic.fetchLive,
//           _liveEpic.processLiveEvents,
//           _liveEpic.addLiveEvents,
//           _paymentSystemEpic.getPaymentsSystems,
//           _withdrawEpic.sendWithdrawRequest,
//           _withdrawEpic.sendWithdrawCupisRequest,
//           _balanceEpic.getBalance,
//           _balanceEpic.throttleBalance,
//           _cmsEpic.getCmsConfig,
//           _rechargeEpic.getWithdrawChannels,
//           _rechargeEpic.getDepositChannels,
//           _favoritesEpic.getFavoriteEvents,
//           _favoritesEpic.addEventToFavorite,
//           _favoritesEpic.deleteEventsFromFavorite,
//           _favoritesEpic.deleteAllEventsFromFavorite,
//           _registrationEpic.fetchQuestions,
//           _registrationEpic.register,
//           _registrationEpic.resendEmail,
//           _registrationEpic.completeRegistration,
//           _documentsEpic.fetchDocuments,
//           _documentsEpic.uploadDocuments,
//           _documentsEpic.fetchDocumentsNextPage,
//           _deeplinkEpic.deeplinkReceived,
//           _deeplinkEpic.handleLastDeeplink,
//           if (storiesIsOn) fetchFirebaseConfig,
//         ],
//       ),
//     ];
