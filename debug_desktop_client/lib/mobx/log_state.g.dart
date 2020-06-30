// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LogState on _LogState, Store {
  final _$isFavoriteAtom = Atom(name: '_LogState.isFavorite');

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  final _$_LogStateActionController = ActionController(name: '_LogState');

  @override
  void setFavorite() {
    final _$actionInfo =
        _$_LogStateActionController.startAction(name: '_LogState.setFavorite');
    try {
      return super.setFavorite();
    } finally {
      _$_LogStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFavorite: ${isFavorite}
    ''';
  }
}
