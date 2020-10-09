import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_profile_state.g.dart';

abstract class UserProfileState implements Built<UserProfileState, UserProfileStateBuilder> {
  UserProfileState._();

  factory UserProfileState([UserProfileStateBuilder updates(UserProfileStateBuilder builder)]) {
    return _$UserProfileState(
      (builder) => builder
        ..logged = false
        ..update(updates),
    );
  }

  static void _initializeBuilder(UserProfileStateBuilder b) {
    b.logged = false;
  }

  @nullable
  String get email;

  bool get logged;

  static Serializer<UserProfileState> get serializer => _$userProfileStateSerializer;
}
