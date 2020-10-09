// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserProfileState> _$userProfileStateSerializer = new _$UserProfileStateSerializer();

class _$UserProfileStateSerializer implements StructuredSerializer<UserProfileState> {
  @override
  final Iterable<Type> types = const [UserProfileState, _$UserProfileState];
  @override
  final String wireName = 'UserProfileState';

  @override
  Iterable<Object> serialize(Serializers serializers, UserProfileState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'logged',
      serializers.serialize(object.logged, specifiedType: const FullType(bool)),
    ];
    if (object.email != null) {
      result..add('email')..add(serializers.serialize(object.email, specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserProfileState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserProfileStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
        case 'logged':
          result.logged = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$UserProfileState extends UserProfileState {
  @override
  final String email;
  @override
  final bool logged;

  factory _$UserProfileState([void Function(UserProfileStateBuilder) updates]) =>
      (new UserProfileStateBuilder()..update(updates)).build();

  _$UserProfileState._({this.email, this.logged}) : super._() {
    if (logged == null) {
      throw new BuiltValueNullFieldError('UserProfileState', 'logged');
    }
  }

  @override
  UserProfileState rebuild(void Function(UserProfileStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  UserProfileStateBuilder toBuilder() => new UserProfileStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfileState && email == other.email && logged == other.logged;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, email.hashCode), logged.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserProfileState')..add('email', email)..add('logged', logged)).toString();
  }
}

class UserProfileStateBuilder implements Builder<UserProfileState, UserProfileStateBuilder> {
  _$UserProfileState _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  bool _logged;
  bool get logged => _$this._logged;
  set logged(bool logged) => _$this._logged = logged;

  UserProfileStateBuilder() {
    UserProfileState._initializeBuilder(this);
  }

  UserProfileStateBuilder get _$this {
    if (_$v != null) {
      _email = _$v.email;
      _logged = _$v.logged;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserProfileState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserProfileState;
  }

  @override
  void update(void Function(UserProfileStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserProfileState build() {
    final _$result = _$v ?? new _$UserProfileState._(email: email, logged: logged);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
