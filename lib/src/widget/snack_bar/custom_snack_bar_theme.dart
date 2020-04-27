import 'package:flutter/material.dart';

import 'custom_snack_bar.dart';

/// {@template custom_snack_bar_theme}
/// This can be used to provide additional theme information for
/// [CustomSnackBar].
///
/// This is not a replacement to [SnackBarThemeData]. But this provide
/// additional control over the [CustomSnackBar]. Note that values from
/// this will override the values in [SnackBarThemeData].
/// {@endtemplate}
class CustomSnackBarTheme {
  /// Default duration that a [SnackBar] is shown.
  final Duration defaultDuration;

  /// Show a [SnackBar] action button with CLEAR as it's text that can be
  /// used to hide the [SnackBar].
  /// If `false`, this action button will not be shown.
  /// Color of the button is getting from [SnackBarThemeData].
  final bool showDefaultAction;

  /// [TextStyle] that is used with the text that is showing in the
  /// [CustomSnackBar].
  final TextStyle textStyle;

  /// Maximum number of lines that the text shown in the [CustomSnackBar]
  /// can have.
  final int maxLines;

  /// Duration that the loading snack bar is shown. If null, this will use
  /// [defaultDuration].
  final Duration loadingSnackBarDuration;

  /// Background color of the loading snack bar. If null, this will use
  /// the background color from [SnackBarThemeData].
  final Color loadingSnackBarColor;

  /// Text style of the loading snack bar. If null, this will use the
  /// [textStyle]
  final TextStyle loadingSnackBarTextStyle;

  /// Duration that the error snack bar is shown. If null, this will use
  /// [defaultDuration].
  final Duration errorSnackBarDuration;

  /// Background color of the error snack bar. If null, this will use
  /// the background color from [SnackBarThemeData].
  final Color errorSnackBarColor;

  /// Text style of the error snack bar. If null, this will use the
  /// [textStyle]
  final TextStyle errorSnackBarTextStyle;

  /// {@macro custom_snack_bar_theme}
  CustomSnackBarTheme({
    this.defaultDuration = const Duration(seconds: 5),
    this.showDefaultAction = true,
    this.textStyle,
    this.maxLines = 2,
    this.loadingSnackBarColor = const Color(0xFF81C784),
    this.loadingSnackBarDuration = const Duration(minutes: 3),
    this.loadingSnackBarTextStyle,
    this.errorSnackBarColor = const Color(0xFFE57373),
    this.errorSnackBarDuration = const Duration(seconds: 10),
    this.errorSnackBarTextStyle,
  });
}
