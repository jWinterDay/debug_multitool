import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color bodyText2Color = Colors.black;

  static const Color dialogBarrierColor = Colors.black45;

  /// 244 244 247
  static const Color gray1 = Color(0xFFF4F4F7);

  /// 228 228 234
  static const Color gray2 = Color(0xFFE4E4EA);

  /// 203 203 212
  static const Color gray3 = Color(0xFFCBCBD4);

  /// 203 203 212
  static const Color gray4 = Color(0xFFCBCBD4);

  /// 153 153 162
  static const Color gray5 = Color(0xFF9999A2);

  /// 72 72 83
  static const Color gray6 = Color(0xFF484853);

  /// 255 255 255
  static const Color background = Colors.white;

  /// 0 154 110
  static const Color positive = Color(0xFF009A6E);

  /// 0 206 147
  static const Color channelConnected = Color(0xFF00CE93);

  /// 153 214 197
  static const Color channelConnecting = Color(0xFF99D6C5);

  /// 153 214 197
  static Color get channelDisconnected => gray3;

  static Color get serverEventFormatError => red;

  static Color channelActiveTitle = Colors.white;

  static Color get channelInactiveTitle => bodyText2Color;

  static const Color red = Colors.red;

  static const Color selected = Colors.pink;

  static const Color eventDelimiter = Colors.orange;

  // 115 97 203
  static const Color autoScrollText = Color(0xFF7361CB);

  static const Color transparent = Colors.transparent;

  static const Color primaryColor = Colors.blue;

  static const Color primaryColorDark = Colors.greenAccent;

  static const Color primaryColorLight = Colors.yellowAccent;

  static const Color scaffoldBackgroundColor = Colors.deepOrange;
}
