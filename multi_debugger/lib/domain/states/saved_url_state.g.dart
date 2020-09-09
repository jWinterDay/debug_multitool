// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_url_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SavedUrlState> _$savedUrlStateSerializer = new _$SavedUrlStateSerializer();

class _$SavedUrlStateSerializer implements StructuredSerializer<SavedUrlState> {
  @override
  final Iterable<Type> types = const [SavedUrlState, _$SavedUrlState];
  @override
  final String wireName = 'SavedUrlState';

  @override
  Iterable<Object> serialize(Serializers serializers, SavedUrlState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'urls',
      serializers.serialize(object.urls,
          specifiedType: const FullType(BuiltMap, const [const FullType(String), const FullType(SavedUrl)])),
    ];

    return result;
  }

  @override
  SavedUrlState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SavedUrlStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'urls':
          result.urls.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [const FullType(String), const FullType(SavedUrl)])));
          break;
      }
    }

    return result.build();
  }
}

class _$SavedUrlState extends SavedUrlState {
  @override
  final BuiltMap<String, SavedUrl> urls;

  factory _$SavedUrlState([void Function(SavedUrlStateBuilder) updates]) =>
      (new SavedUrlStateBuilder()..update(updates)).build();

  _$SavedUrlState._({this.urls}) : super._() {
    if (urls == null) {
      throw new BuiltValueNullFieldError('SavedUrlState', 'urls');
    }
  }

  @override
  SavedUrlState rebuild(void Function(SavedUrlStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  SavedUrlStateBuilder toBuilder() => new SavedUrlStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SavedUrlState && urls == other.urls;
  }

  @override
  int get hashCode {
    return $jf($jc(0, urls.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SavedUrlState')..add('urls', urls)).toString();
  }
}

class SavedUrlStateBuilder implements Builder<SavedUrlState, SavedUrlStateBuilder> {
  _$SavedUrlState _$v;

  MapBuilder<String, SavedUrl> _urls;
  MapBuilder<String, SavedUrl> get urls => _$this._urls ??= new MapBuilder<String, SavedUrl>();
  set urls(MapBuilder<String, SavedUrl> urls) => _$this._urls = urls;

  SavedUrlStateBuilder();

  SavedUrlStateBuilder get _$this {
    if (_$v != null) {
      _urls = _$v.urls?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SavedUrlState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SavedUrlState;
  }

  @override
  void update(void Function(SavedUrlStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SavedUrlState build() {
    _$SavedUrlState _$result;
    try {
      _$result = _$v ?? new _$SavedUrlState._(urls: urls.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'urls';
        urls.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError('SavedUrlState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
