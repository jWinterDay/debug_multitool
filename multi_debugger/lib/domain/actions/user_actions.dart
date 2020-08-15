// import 'package:built_collection/built_collection.dart';
// import 'package:built_redux/built_redux.dart';
// import 'package:ligastavok/domain/actions/actions.dart';
// import 'package:ligastavok/domain/actions/reset_password_action_model.dart';
// import 'package:ligastavok/domain/actions/reusable_action.dart';
// import 'package:ligastavok/domain/models/balance_model.dart';
// import 'package:ligastavok/domain/models/bet/bet_state_filter_type.dart';
// import 'package:ligastavok/domain/models/common/bool_result_model.dart';
// import 'package:ligastavok/domain/models/common/error_model.dart';
// import 'package:ligastavok/domain/models/common/meta.dart';
// import 'package:ligastavok/domain/models/order.dart';
// import 'package:ligastavok/domain/models/profile_item.dart';
// import 'package:ligastavok/domain/models/sign_in_result_model.dart';
// import 'package:ligastavok/domain/models/userOrders.dart';
// import 'package:ligastavok/domain/models/user_info.dart';
// import 'package:ligastavok/domain/models/user_info_model.dart';
// import 'package:ligastavok/domain/states/states.dart';
// import 'package:ligastavok/domain/states/user_state.dart';
// import 'package:ligastavok/feature/reset_password/domain/state/reset_password_state.dart';

// part 'user_actions.g.dart';

// abstract class UserActions extends ReduxActions {
//   UserActions._();

//   factory UserActions() = _$UserActions;

//   Future<bool> login(Map<String, String> loginPassword, Store<AppState, AppStateBuilder, AppActions> store) {
//     return Future(() async {
//       final request = {
//         "login": loginPassword['login'],
//         "password": loginPassword['password'],
//         "captcha": "secret_key",
//         "captchaType": "invisible",
//       };
//       doLogin(request);
//       final change = await store
//           .actionStream(UserActionsNames.setLoggedInResult)
//           .firstWhere((element) => !element.action.payload.passwordChangeRequired);

//       if (change.action.payload.result.error != null) {
//         throw change.action.payload.result.error;
//       }
//       return change.action.payload.result.result;
//     });
//   }

//   Future<bool> requestResetPasswordFunc(String email, store) {
//     return Future(() async {
//       requestResetPassword(email);
//       final change = await store.actionStream(UserActionsNames.setRequestResetPasswordResult).first;

//       if (change.action.payload.error != null) {
//         throw change.action.payload.error;
//       }
//       return change.action.payload.result as bool;
//     });
//   }

//   Future<bool> sendNewPasswordByResetFunc(String newPass, String resetToken, Store store) {
//     return Future(() async {
//       resetPassword(ResetPasswordActionModel(newPass, resetToken));
//       final change = await store.actionStream(UserActionsNames.setResetPasswordResult).first;

//       if (change.action.payload.error != null) {
//         throw change.action.payload.error;
//       }
//       return change.action.payload.result;
//     });
//   }

//   Future<bool> sendNewPasswordByChangeFunc(String newPass, String oldPassword, Store store) {
//     return Future(() async {
//       changePassword(ChangePasswordActionModel(newPass, oldPassword));
//       final change = await store.actionStream(UserActionsNames.setChangePasswordResult).first;
//       if (change.action.payload.error != null) {
//         throw change.action.payload.error;
//       }
//       return change.action.payload.result;
//     });
//   }

//   Future<UserInfo> getUpdateUserInfoFuture(store) async {
//     getUserInfo();

//     final change = await store.actionStream(UserActionsNames.setUserInfo).first;

//     if (change.action.payload.error != null) {
//       throw change.action.payload.error;
//     }

//     return change.action.payload.result as UserInfo;
//   }

//   ActionDispatcher<String> get requestResetPassword;

//   ActionDispatcher<BoolResultModel> get setRequestResetPasswordResult;

//   ActionDispatcher<ResetPasswordActionModel> get resetPassword;

//   ActionDispatcher<BoolResultModel> get setResetPasswordResult;

//   ActionDispatcher<ChangePasswordActionModel> get changePassword;

//   ActionDispatcher<ChangePasswordActionModel> get updatePassword;

//   ActionDispatcher<BoolResultModel> get setChangePasswordResult;

//   ActionDispatcher<BoolResultModel> get setUpdatePasswordResult;

//   ActionDispatcher<String> get findUser;

//   ActionDispatcher<bool> get setFindUserResult;

//   ActionDispatcher<ResetPasswordState> get setResetPasswordState;

//   ActionDispatcher<UserState> get setUserState;

//   ActionDispatcher<void> get storeUserState;

//   ActionDispatcher<void> get restoreUserState;

//   ActionDispatcher<void> get clearUserState;

//   ActionDispatcher<void> get getUserInfo;

//   ActionDispatcher<UserInfoModel> get setUserInfo;

//   ActionDispatcher<void> get baseAuth;

//   ActionDispatcher<Meta> get baseAuthComplete;

//   ActionDispatcher<Map<String, String>> get doLogin;

//   ActionDispatcher<void> get logout;

//   ActionDispatcher<void> get clearLogin;

//   ActionDispatcher<void> get getBalance;

//   ActionDispatcher<String> get setPinCode;

//   ActionDispatcher<Map<int, Order>> get setOrders;

//   ActionDispatcher<UserOrders> get setUserOrders;

//   ActionDispatcher<UserOrders> get setUserOrdersCart;

//   ActionDispatcher<Meta> get setUserMeta;

//   ActionDispatcher<ReusableAction> refreshTokenWithResumeAction;

//   ActionDispatcher<void> refreshToken;

//   ActionDispatcher<BalanceModel> get setBalance;

//   ActionDispatcher<SignInResultModel> get setLoggedInResult;

//   ActionDispatcher<ErrorModel> get setError;

//   ActionDispatcher<BuiltList<ProfileItem>> get setProfileItems;

//   ActionDispatcher<void> get refreshTokenExpired;

//   ActionDispatcher<double> get changeExpressBetValue;

//   ActionDispatcher<double> get changeFontScaleSetting;

//   ActionDispatcher<bool> get setAuthByBiometricEnable;

//   //todo: fixme merge ( move to bet actions?)
//   ActionDispatcher<BetStateFilterType> get setBetFilterSetting;

//   ActionDispatcher<String> get setBetFilterCalendarPeriod;

//   ActionDispatcher<void> get throttleBalance;

//   ActionDispatcher<void> get initToken;

//   ActionDispatcher<Set<int>> get setViewedFreebets;

//   ActionDispatcher<void> get clearViewedFreebets;
// }
