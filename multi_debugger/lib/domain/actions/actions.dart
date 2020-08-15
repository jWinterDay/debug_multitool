// import 'package:built_collection/built_collection.dart';
// import 'package:built_redux/built_redux.dart';
// import 'package:ligastavok/domain/actions/event_detail_actions.dart';
// import 'package:ligastavok/domain/actions/live_actions.dart';
// import 'package:ligastavok/domain/actions/sport_book_actions.dart';
// import 'package:ligastavok/domain/models/app_route.dart';
// import 'package:ligastavok/domain/models/config/network_config.dart';
// import 'package:ligastavok/domain/models/dialog_bundle.dart';
// import 'package:ligastavok/domain/models/life_cycle.dart';
// import 'package:ligastavok/feature/deeplink/domain/action/deeplink_actions.dart';
// import 'package:ligastavok/feature/documents/domain/action/documents_actions.dart';
// import 'package:ligastavok/feature/favorites/redux/action/favorite_actions.dart';
// import 'package:ligastavok/feature/identification/redux/action/identification_actions.dart';
// import 'package:ligastavok/feature/making_bet_next/domain/action/make_bet_actions.dart';
// import 'package:ligastavok/feature/navigation/navigator.dart';
// import 'package:ligastavok/feature/promocode/redux/promocode_actions.dart';
// import 'package:ligastavok/feature/recharge/domain/action/recharge_actions.dart';
// import 'package:ligastavok/feature/registration/domain/action/registration_actions.dart';
// import 'package:ligastavok/feature/registration_next/domain/action/registration_next_actions.dart';
// import 'package:ligastavok/feature/reset_password/domain/action/reset_password_actions.dart';
// import 'package:ligastavok/feature/search/domain/search_actions.dart';
// import 'package:ligastavok/feature/stories/redux/action/stories_actions.dart';
// import 'package:ligastavok/feature/video_broadcast/video_broadcast.dart';

// import 'alerts_actions.dart';
// import 'archive_actions.dart';
// import 'auth_actions.dart';
// import 'bet_details_actions.dart';
// import 'cart/bet_actions.dart';
// import 'cart/cart_actions.dart';
// import 'cms_actions.dart';
// import 'config_actions.dart';
// import 'eventlist.dart';
// import 'favorites_actions.dart';
// import 'line.dart';
// import 'payments.dart';
// import 'sport_book_actions.dart';
// import 'subscription.dart';
// import 'user_actions.dart';

// part 'actions.g.dart';

// abstract class AppActions extends ReduxActions {
//   AppActions._();

//   factory AppActions() = _$AppActions;

//   ActionDispatcher<NetworkConfig> get init;
//   ActionDispatcher<bool> get ready;
//   ActionDispatcher<bool> get setOffline;
//   ActionDispatcher<bool> get setOutOfService;
//   ActionDispatcher<bool> get setWebSocketStatus;

//   ActionDispatcher<AppLifecycle> get appLifecycle;

//   /// for push
//   ActionDispatcher<String> get registerDeviceToken;
//   ActionDispatcher<bool> get setDeviceTokenRegistered;

//   ActionDispatcher<String> get onDeepLinkReceived;
//   ActionDispatcher<void> get obtainDeepLink;
//   ActionDispatcher<void> get startSplashScreenTimer;
//   ActionDispatcher<void> get tryToRouteFromDeepLink;

//   ActionDispatcher<void> get store;
//   ActionDispatcher<void> get restore;
//   ActionDispatcher<void> get userStateReady;
//   ActionDispatcher<BuiltList<String>> get setSettings;

//   ActionDispatcher<AppRoute> get routeTo;

//   ActionDispatcher<String> get setRoute;
//   ActionDispatcher<DialogBundle> get showDialog;
//   ActionDispatcher<bool> get hideStatusBar;
//   ActionDispatcher<bool> get waitForPincode;

//   ActionDispatcher<void> get refresh;

//   DeeplinkActions get deeplink;
//   ConfigActions get config;
//   CmsActions get cmsActions;
//   BetActions get bet;
//   MakeBetActions get makingBet;
//   UserActions get user;
//   RegistrationActions get registrationActions;
//   RegistrationNextActions get registrationNext;
//   EventListActions get eventList;
//   CartActions get cart;
//   LineActions get line;
//   LiveActions get live;
//   FavoritesActions get favorites;
//   StoriesActions get stories;
//   SportBookActions get sportbook;
//   SearchActions get search;
//   PaymentsActions get payments;
//   AuthActions get auth;
//   AlertsActions get alerts;

//   DocumentsActions get documents;

//   SubscriptionActions get subscription;
//   BetDetailsActions get betDetails;
//   VideoPlayerActions get videoPlayer;
//   PlayersStockActions get playersStock;

//   ArchiveActions get archive;
//   RechargeActions get recharge;
//   FavoriteActions get favorite;
//   IdentificationActions get identification;

//   EventDetailActions get eventDetail;
//   NavigatorActions get navigator;

//   ActionDispatcher<bool> get enableWebsocketLogging;

//   PromocodeActions get promocodeActions;

//   ResetPasswordActions get resetPasswordActions;
// }
