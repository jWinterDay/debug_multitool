import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:multi_debugger/domain/models/models.dart';

part 'saved_url_state.g.dart';

abstract class SavedUrlState implements Built<SavedUrlState, SavedUrlStateBuilder> {
  SavedUrlState._();

  factory SavedUrlState([SavedUrlStateBuilder updates(SavedUrlStateBuilder builder)]) = _$SavedUrlState;

  /// <url id, url>
  BuiltMap<String, SavedUrl> get urls;

  static Serializer<SavedUrlState> get serializer => _$savedUrlStateSerializer;
}
