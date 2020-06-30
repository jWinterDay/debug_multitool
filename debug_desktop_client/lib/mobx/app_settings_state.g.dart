// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppSettingsState on _AppSettingsState, Store {
  final _$scrollToEndAtom = Atom(name: '_AppSettingsState.scrollToEnd');

  @override
  bool get scrollToEnd {
    _$scrollToEndAtom.reportRead();
    return super.scrollToEnd;
  }

  @override
  set scrollToEnd(bool value) {
    _$scrollToEndAtom.reportWrite(value, super.scrollToEnd, () {
      super.scrollToEnd = value;
    });
  }

  final _$_AppSettingsStateActionController =
      ActionController(name: '_AppSettingsState');

  @override
  void setScrollToEnd(bool val) {
    final _$actionInfo = _$_AppSettingsStateActionController.startAction(
        name: '_AppSettingsState.setScrollToEnd');
    try {
      return super.setScrollToEnd(val);
    } finally {
      _$_AppSettingsStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollToEnd: ${scrollToEnd}
    ''';
  }
}
