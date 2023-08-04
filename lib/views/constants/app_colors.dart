import 'package:flutter/material.dart';
import 'package:instagram_clone/extension/string/as_html_color_to_color.dart';

@immutable
class AppColor {
  static final loginButtonColor = '#cfc9c2'.htmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.htmlColorToColor();
  const AppColor._();
}
