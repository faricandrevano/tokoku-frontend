import 'package:flutter/material.dart';
import 'package:shamo_mobile/core/core.dart';

/// Extension theme
extension ThemeExtension on BuildContext {
  /// Current [ThemeData] in your widget
  ThemeData get theme => Theme.of(this);

  /// Get Adaptive Theme with current style
  AdaptiveTheme get adaptiveTheme => AdaptiveTheme(themeData: theme);
}
