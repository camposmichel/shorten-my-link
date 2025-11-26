import 'package:flutter/material.dart';

sealed class AppTheme {
  static const Color primaryColor = Color(0xFF9014FE);
  static Color primaryColorLight = primaryColor.withOpacity(0.01);
  static Color errorColor = Colors.redAccent;
}
