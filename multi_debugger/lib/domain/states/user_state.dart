// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';
// import 'package:ligastavok/domain/models/balance_model.dart';
// import 'package:ligastavok/domain/models/bet/bet_state_filter_type.dart';
// import 'package:ligastavok/domain/models/common/base_model.dart';
// import 'package:ligastavok/domain/models/confirm_email_model.dart';
// import 'package:ligastavok/domain/models/order.dart';
// import 'package:ligastavok/domain/models/payment_model.dart';
// import 'package:ligastavok/domain/models/profile_item.dart';
// import 'package:ligastavok/domain/models/user/user_status.dart';
// import 'package:ligastavok/domain/models/userOrders.dart';
// import 'package:ligastavok/domain/models/user_info.dart';

// part 'user_state.g.dart';

// const String xApplicationName = 'mobapp2';

// abstract class UserState implements Built<UserState, UserStateBuilder> {
//   UserState._();

//   factory UserState([updates(UserStateBuilder builder)]) {
//     return _$UserState((builder) => builder
//       .._loggedIn = false
//       ..loadingBalance = false
//       ..loadingMyBets = false
//       ..isAuthByBiometricEnable = true
//       .._expressBetValue = 50
//       ..fontScaleSetting = 1.0
//       ..activeBetStateFilterType = BetStateFilterType.all
//       ..orders.replace(<int, Order>{})
//       ..userOrders.replace(UserOrders())
//       ..loggingInWrongTryCount = 0
//       ..viewedFreebets.replace(<int>{})
//       ..update(updates));
//   }

//   @nullable
//   bool get loggedIn;

//   @nullable
//   int get loggingInWrongTryCount;

//   @nullable
//   String get lastLoggingInWrongTryTime;

//   bool get isLoggedIn => meta?.token?.isNotEmpty ?? false;

//   @nullable
//   bool get loggingIn;

//   @nullable
//   String get pinCode;

//   @BuiltValueField(serialize: false)
//   bool get isPinEmpty => pinCode?.isEmpty ?? true;

//   @BuiltValueField(serialize: false)
//   @nullable
//   bool get isRequestResetPasswordSucessed;

//   @BuiltValueField(serialize: false)
//   @nullable
//   bool get isResetPasswordSucessed;

//   @BuiltValueField(serialize: false)
//   @nullable
//   bool get isChangePasswordSucessed;

//   @nullable
//   String get userLogin;

//   @nullable
//   UserInfo get userInfo;

//   @nullable
//   @BuiltValueField(serialize: false)
//   ErrorModel get error;

//   @nullable
//   Meta get meta;

//   @nullable
//   @BuiltValueField(serialize: false)
//   BalanceModel get balance;

//   // According to buisness logic keep info about freebets that were viewed by user in his profile
//   BuiltSet<int> get viewedFreebets;

//   @nullable
//   @BuiltValueField(serialize: false)
//   bool get loadingBalance;

//   @nullable
//   @BuiltValueField(serialize: false)
//   bool get loadingMyBets;

//   @nullable
//   @BuiltValueField(serialize: false)
//   PaymentModel get paymentsHistory;

//   @BuiltValueField(serialize: false)
//   BuiltList<ProfileItem> get profileItems;

//   @nullable
//   @BuiltValueField(serialize: false)
//   UserOrders get userOrders;

//   @nullable
//   @BuiltValueField(serialize: false)
//   UserOrders get userOrdersCart;

//   @nullable
//   @BuiltValueField(serialize: false)
//   BuiltMap<int, Order> get orders;

//   @nullable
//   String get timeStamp;

//   @nullable
//   String get resetPasswordRequestTimeStamp;

//   @nullable
//   @BuiltValueField(serialize: false)
//   ConfirmEmailResultModel get emailConfirm;

//   UserStatus userStatus(store) => userInfo == null ? UserStatus.guestUserStatus : userInfo.getUserStatus(store);

//   /// Размер значения для "экспресс" ставки. Меняется в настройках, в профиле.
//   @nullable
//   double get expressBetValue;

//   /// Application global Font scale factor
//   @nullable
//   double get fontScaleSetting;

//   @nullable
//   bool get isAuthByBiometricEnable;

//   @nullable
//   BetStateFilterType get activeBetStateFilterType;

//   @nullable
//   String get activeBetFilterCalendarPeriod;

//   bool isLoadingBalance() {
//     // by default we return 'true' in prefer of loading than 'null balance'
//     return (balance == null) || (loadingBalance ?? true);
//   }

//   bool isUserIdentified() {
//     return (userInfo == null) ? false : userInfo.registrationComplete;
//   }

//   bool canBindAccount() {
//     return !(userInfo?.registrationComplete ?? true) &&
//         userInfo.confirmedEmail &&
//         userInfo.confirmedMobile &&
//         !userInfo.prepareRequestSent &&
//         !userInfo.confirmedCupis &&
//         error == null;
//   }

//   bool isBalanceAvailable() {
//     return userInfo?.confirmedEmail ?? false;
//   }

//   bool isIdentified() {
//     return userInfo?.registrationComplete ?? false;
//   }

//   bool isSimpleIdentityFailed() {
//     return userInfo.simpleIdentCupisFailed &&
//         !userInfo.simpleIdentCupisBadScan &&
//         !userInfo.simpleIdentTriesExceeded &&
//         !userInfo.simpleIdentTriesExceeded;
//   }

//   static Map<String, String> prepareLoginRequestMap(String login, String psw) =>
//       {"login": login, "password": psw, "captcha": "secret_key", "captchaType": "invisible"};

//   static Serializer<UserState> get serializer => _$userStateSerializer;
// }
