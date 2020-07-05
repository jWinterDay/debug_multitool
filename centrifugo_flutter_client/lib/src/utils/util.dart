const String kUrlKey = 'centrifugoUrl';
const String kChannelKey = 'centrifugoChannel';

String formatEnumToStr(String enumString) {
  return enumString.split('.')[1];
}

String urlFieldValidator(String val) {
  if (val.isEmpty) {
    return 'Enter url';
  }
  return null;
}

String channelFieldValidator(String val) {
  if (val.isEmpty) {
    return 'Enter channel name';
  }
  return null;
}
