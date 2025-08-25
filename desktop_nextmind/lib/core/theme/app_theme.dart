import 'package:flutter/material.dart';
import 'theme.dart';

class AppTheme {
  static ThemeData light(TextTheme textTheme) {
    final theme = MaterialTheme(textTheme);
    return theme.light();
  }

  static ThemeData dark(TextTheme textTheme) {
    final theme = MaterialTheme(textTheme);
    return theme.dark();
  }
}
