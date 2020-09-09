// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_url.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SavedUrl extends SavedUrl {
  @override
  final String savedUrlId;
  @override
  final String url;
  @override
  final bool custom;

  factory _$SavedUrl([void Function(SavedUrlBuilder) updates]) => (new SavedUrlBuilder()..update(updates)).build();

  _$SavedUrl._({this.savedUrlId, this.url, this.custom}) : super._() {
    if (savedUrlId == null) {
      throw new BuiltValueNullFieldError('SavedUrl', 'savedUrlId');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('SavedUrl', 'url');
    }
    if (custom == null) {
      throw new BuiltValueNullFieldError('SavedUrl', 'custom');
    }
  }

  @override
  SavedUrl rebuild(void Function(SavedUrlBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  SavedUrlBuilder toBuilder() => new SavedUrlBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SavedUrl && savedUrlId == other.savedUrlId && url == other.url && custom == other.custom;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, savedUrlId.hashCode), url.hashCode), custom.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SavedUrl')
          ..add('savedUrlId', savedUrlId)
          ..add('url', url)
          ..add('custom', custom))
        .toString();
  }
}

class SavedUrlBuilder implements Builder<SavedUrl, SavedUrlBuilder> {
  _$SavedUrl _$v;

  String _savedUrlId;
  String get savedUrlId => _$this._savedUrlId;
  set savedUrlId(String savedUrlId) => _$this._savedUrlId = savedUrlId;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  bool _custom;
  bool get custom => _$this._custom;
  set custom(bool custom) => _$this._custom = custom;

  SavedUrlBuilder() {
    SavedUrl._initializeBuilder(this);
  }

  SavedUrlBuilder get _$this {
    if (_$v != null) {
      _savedUrlId = _$v.savedUrlId;
      _url = _$v.url;
      _custom = _$v.custom;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SavedUrl other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SavedUrl;
  }

  @override
  void update(void Function(SavedUrlBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SavedUrl build() {
    final _$result = _$v ?? new _$SavedUrl._(savedUrlId: savedUrlId, url: url, custom: custom);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
