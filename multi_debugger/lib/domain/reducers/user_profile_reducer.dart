// import 'package:built_collection/built_collection.dart';
// import 'package:built_redux/built_redux.dart';
// import 'package:ligastavok/domain/actions/cart/bet_actions.dart';
// import 'package:ligastavok/domain/actions/payments.dart';
// import 'package:ligastavok/domain/actions/user_actions.dart';
// import 'package:ligastavok/domain/models/balance_model.dart';
// import 'package:ligastavok/domain/models/bet/bet_state_filter_type.dart';
// import 'package:ligastavok/domain/models/common/bool_result_model.dart';
// import 'package:ligastavok/domain/models/common/error_model.dart';
// import 'package:ligastavok/domain/models/common/meta.dart';
// import 'package:ligastavok/domain/models/order.dart';
// import 'package:ligastavok/domain/models/payment_model.dart';
// import 'package:ligastavok/domain/models/profile_item.dart';
// import 'package:ligastavok/domain/models/sign_in_result_model.dart';
// import 'package:ligastavok/domain/models/userOrders.dart';
// import 'package:ligastavok/domain/models/user_info_model.dart';
// import 'package:ligastavok/domain/states/states.dart';
// import 'package:ligastavok/domain/states/user_state.dart';

// NestedReducerBuilder<AppState, AppStateBuilder, UserState, UserStateBuilder> createUserReducer() =>
//     NestedReducerBuilder<AppState, AppStateBuilder, UserState, UserStateBuilder>(
//       (state) => state.userState,
//       (builder) => builder.userState,
//     )
//       ..add<Map<String, String>>(UserActionsNames.doLogin, _logginIn)
//       ..add<UserState>(UserActionsNames.setUserState, _setUserState)
//       ..add<void>(UserActionsNames.logout, _logout)
//       ..add<BoolResultModel>(UserActionsNames.setRequestResetPasswordResult, _setRequestResetPasswordResult)
//       ..add<BoolResultModel>(UserActionsNames.setResetPasswordResult, _setResetPasswordResult)
//       ..add<BoolResultModel>(UserActionsNames.setChangePasswordResult, _setChangePasswordResult)
//       ..add<SignInResultModel>(UserActionsNames.setLoggedInResult, _onSetLoggedInResult)
//       ..add<UserInfoModel>(UserActionsNames.setUserInfo, _onSetUserInfo)
//       ..add<ErrorModel>(UserActionsNames.setError, _setError)
//       ..add<Meta>(UserActionsNames.setUserMeta, _setUserMeta)
//       ..add<Meta>(UserActionsNames.baseAuthComplete, _setUserMeta)
//       ..add<String>(UserActionsNames.setPinCode, _setPinCode)
//       ..add<BalanceModel>(UserActionsNames.setBalance, _setBalance)
//       ..add<PaymentModel>(PaymentsActionsNames.setPaymentsHistory, _setPaymentsHistory)
//       ..add<Map<int, Order>>(UserActionsNames.setOrders, _setOrders)
//       ..add<UserOrders>(UserActionsNames.setUserOrders, _setUserOrders)
//       ..add<UserOrders>(UserActionsNames.setUserOrdersCart, _setUserOrdersCart)
//       ..add<Order>(BetActionsNames.setOrder, _onSetOrder)
//       ..add<BuiltList<ProfileItem>>(UserActionsNames.setProfileItems, _setProfileItems)
//       ..add<void>(UserActionsNames.clearUserState, _clearUserState)
//       ..add<double>(UserActionsNames.changeExpressBetValue, _onChangeExpressBetValue)
//       ..add<double>(UserActionsNames.changeFontScaleSetting, _onChangeFontScaleSetting)
//       ..add<bool>(UserActionsNames.setAuthByBiometricEnable, _onSetAuthByBiometricEnable)
//       ..add(UserActionsNames.setAuthByBiometricEnable, _onSetAuthByBiometricEnable)
//       ..add<void>(UserActionsNames.getBalance, _getBalance)
//       ..add<void>(UserActionsNames.clearLogin, _clearLogin)
//       ..add<BetStateFilterType>(UserActionsNames.setBetFilterSetting, _setBetFilterSetting)
//       ..add<String>(UserActionsNames.setBetFilterCalendarPeriod, _setBetFilterCalendarPeriod)
//       ..add<void>(BetActionsNames.getBetHistory, _onGetBetHistory)
//       ..add<Map<String, String>>(UserActionsNames.doLogin, _onTryLogin)
//       ..add<Set<int>>(UserActionsNames.setViewedFreebets, _onSetViewedFreebets)
//       ..add<void>(UserActionsNames.clearViewedFreebets, _onClearViewedFreebets);

// void _clearLogin(UserState state, Action<void> action, UserStateBuilder builder) => builder..userLogin = null;

// void _getBalance(UserState state, Action<void> action, UserStateBuilder builder) => builder..loadingBalance = true;

// void _clearUserState(UserState state, Action<void> action, UserStateBuilder builder) => builder..replace(UserState());

// void _logginIn(UserState state, Action<Map<String, String>> action, UserStateBuilder builder) => builder
//   ..loggingIn = true
//   ..userLogin = action.payload['login'];

// void _logout(UserState state, Action<void> action, UserStateBuilder builder) {
//   builder
//     ..userInfo = null
//     ..pinCode = null
//     ..loggedIn = false
//     ..balance = null
//     ..meta = null
//     ..paymentsHistory = null
//     ..orders = null
//     ..emailConfirm = null;
// }

// void _setRequestResetPasswordResult(UserState state, Action<BoolResultModel> action, UserStateBuilder builder) =>
//     builder
//       ..resetPasswordRequestTimeStamp = DateTime.now().toIso8601String()
//       ..isRequestResetPasswordSucessed = action.payload.result
//       ..error = action.payload?.error?.toBuilder()
//       ..timeStamp = DateTime.now().toUtc().toIso8601String();

// void _setResetPasswordResult(UserState state, Action<BoolResultModel> action, UserStateBuilder builder) => builder
//   ..isResetPasswordSucessed = action.payload.result
//   ..error = action.payload?.error?.toBuilder()
//   ..timeStamp = DateTime.now().toUtc().toIso8601String();

// void _setChangePasswordResult(UserState state, Action<BoolResultModel> action, UserStateBuilder builder) => builder
//   ..isChangePasswordSucessed = action.payload.result
//   ..error = action.payload?.error?.toBuilder()
//   ..timeStamp = DateTime.now().toUtc().toIso8601String();

// void _onSetLoggedInResult(UserState state, Action<SignInResultModel> action, UserStateBuilder builder) {
//   builder
//     ..loggingIn = false
//     ..loggedIn = action.payload.result.result
//     ..meta = action?.payload?.result?.meta?.toBuilder()
//     ..error = action.payload?.result?.error?.toBuilder();

//   ErrorModel error = action.payload?.result?.error;

//   if (error != null) {
//     if (error.code == 57017) {
//       builder
//         ..loggingInWrongTryCount = ((state.loggingInWrongTryCount ?? 0) + 1)
//         ..lastLoggingInWrongTryTime = DateTime.now().toIso8601String();
//     }
//   } else {
//     builder
//       ..loggingInWrongTryCount = 0
//       ..lastLoggingInWrongTryTime = null;
//   }
// }

// void _onSetUserInfo(UserState state, Action<UserInfoModel> action, UserStateBuilder builder) {
//   if (action.payload.error != null) {
//     builder.error = action.payload.error.toBuilder();
//   } else {
//     builder.error = null;
//     builder.userInfo.replace(action.payload.result);
//     // if ((state.cypisState != null || state.cypisStateError != null) && action.payload.result.confirmedCupis) {
//     //   builder
//     //     ..cypisState = null
//     //     ..cypisStateError = null;
//     // }
//   }

//   builder.timeStamp = DateTime.now().toUtc().toIso8601String();
// }

// void _setUserState(UserState state, Action<UserState> action, UserStateBuilder builder) => builder
//   ..replace(action.payload)
//   ..timeStamp = DateTime.now().toUtc().toIso8601String();

// void _setError(UserState state, Action<ErrorModel> action, UserStateBuilder builder) => builder
//   ..loggingIn = false
//   ..error.replace(action.payload);

// void _setOrders(UserState state, Action<Map<int, Order>> action, UserStateBuilder builder) {
//   builder
//     ..orders.replace(BuiltMap<int, Order>.of(action.payload))
//     ..loadingMyBets = false;
// }

// void _setUserOrders(UserState state, Action<UserOrders> action, UserStateBuilder builder) {
//   builder.userOrders.replace(action.payload);
// }

// void _setUserOrdersCart(UserState state, Action<UserOrders> action, UserStateBuilder builder) {
//   builder.userOrdersCart.replace(action.payload);
// }

// void _setUserMeta(UserState state, Action<Meta> action, UserStateBuilder builder) {
//   builder.meta.replace(action.payload);
// }

// void _setPinCode(UserState state, Action<String> action, UserStateBuilder builder) => builder..pinCode = action.payload;

// void _setBalance(UserState state, Action<BalanceModel> action, UserStateBuilder builder) => builder
//   ..balance.replace(action.payload)
//   ..loadingBalance = false
//   ..timeStamp = DateTime.now().toUtc().toIso8601String();

// void _setPaymentsHistory(UserState state, Action<PaymentModel> action, UserStateBuilder builder) =>
//     builder..paymentsHistory.replace(action.payload);

// void _setProfileItems(UserState state, Action<BuiltList<ProfileItem>> action, UserStateBuilder builder) =>
//     builder..profileItems.replace(action.payload);

// void _onChangeExpressBetValue(UserState state, Action<double> action, UserStateBuilder builder) {
//   builder.expressBetValue = action.payload;
// }

// void _onChangeFontScaleSetting(UserState state, Action<double> action, UserStateBuilder builder) {
//   builder.fontScaleSetting = action.payload;
// }

// void _onSetAuthByBiometricEnable(UserState state, Action<bool> action, UserStateBuilder builder) {
//   builder.isAuthByBiometricEnable = action.payload;
// }

// void _onGetBetHistory(UserState state, Action<void> action, UserStateBuilder builder) {
//   builder.loadingMyBets = true;
// }

// void _onSetOrder(UserState state, Action<Order> action, UserStateBuilder builder) {
//   builder.timeStamp = DateTime.now().toUtc().toIso8601String();
//   builder.orders.updateValue(action.payload.barcode, (order) => action.payload, ifAbsent: () => action.payload);
// }

// void _setBetFilterSetting(UserState state, Action<BetStateFilterType> action, UserStateBuilder builder) =>
//     builder..activeBetStateFilterType = action.payload;

// void _setBetFilterCalendarPeriod(UserState state, Action<String> action, UserStateBuilder builder) =>
//     builder..activeBetFilterCalendarPeriod = action.payload;

// void _onTryLogin(UserState state, Action<Map<String, String>> action, UserStateBuilder builder) {
//   final String userLogin = action.payload['login'];
//   builder.userLogin = userLogin;
//   if (userLogin != state.userLogin) {
//     builder.loggingInWrongTryCount = 0;
//   }
// }

// void _onSetViewedFreebets(UserState state, Action<Set<int>> action, UserStateBuilder builder) {
//   builder.viewedFreebets.addAll(action.payload);
// }

// void _onClearViewedFreebets(UserState state, Action<void> action, UserStateBuilder builder) {
//   builder.viewedFreebets.replace(<int>{});
// }
