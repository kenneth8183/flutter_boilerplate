import 'package:flutter/material.dart';

Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
Color secondaryAppColor = hexToColor('#22DDA6');
const Color secondaryDarkAppColor = Colors.white;
Color tipColor = hexToColor('#B6B6B6');
const Color lightGray = Color(0xFFF6F6F6);
const Color darkGray = Color(0xFF9F9F9F);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
