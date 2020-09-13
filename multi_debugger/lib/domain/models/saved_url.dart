import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
// import 'package:uuid/uuid.dart';

part 'saved_url.g.dart';

abstract class SavedUrl implements Built<SavedUrl, SavedUrlBuilder> {
  SavedUrl._();

  factory SavedUrl([SavedUrlBuilder updates(SavedUrlBuilder buider)]) = _$SavedUrl;

  static void _initializeBuilder(SavedUrlBuilder b) => b
    // ..savedUrlId = Uuid().v4()
    ..custom = true;

  String get savedUrlId => url; // url as id for distinct the same urls

  String get url;

  bool get custom;

  static Serializer<SavedUrl> get serializer => _$savedUrlSerializer;
}
