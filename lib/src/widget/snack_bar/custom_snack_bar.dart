import 'package:flutter/material.dart';

import 'custom_snack_bar_theme.dart';

/// {@template custom_snack_bar}
/// Create a [SnackBar] directly from [ScaffoldMessenger].
///
/// As earlier way of showing [SnackBar] from [ScaffoldState]
/// (or `scaffoldKey`) is deprecated, you will have to wrap your
/// [Scaffold]s with a [ScaffoldMessenger] to show a [SnackBar].
///
/// For more information, see the documentation of [ScaffoldMessenger].
/// {@endtemplate}
class CustomSnackBar {
  late ScaffoldMessengerState _messengerState;

  /// Additional theme information for [CustomSnackBar]
  static CustomSnackBarTheme customTheme = CustomSnackBarTheme();

  /// {@macro custom_snack_bar}
  CustomSnackBar({required BuildContext context}) {
    _messengerState = ScaffoldMessenger.of(context);
  }

  /// Shows a SnackBar with given error [msg]
  void showErrorSnackBar(
    String msg, {
    Color? backgroundColor,
    Duration? duration,
  }) {
    showSnackBar(
      text: "Error: $msg",
      textStyle: customTheme.errorSnackBarTextStyle,
      color: backgroundColor ?? customTheme.errorSnackBarColor,
      duration: duration ?? customTheme.errorSnackBarDuration,
    );
  }

  /// Show a Loading SnackBar for 1 minute
  void showLoadingSnackBar({Color? backgroundColor, Duration? duration}) {
    hideAll();
    final snackBar = SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 10.0),
          Text(
            "Loading...",
            style: customTheme.loadingSnackBarTextStyle,
          ),
        ],
      ),
      backgroundColor: backgroundColor ?? customTheme.loadingSnackBarColor,
      duration: duration ?? customTheme.loadingSnackBarDuration,
    );
    showRawSnackBar(snackBar);
  }

  /// Show a [SnackBar] with [text] (maximum 2 lines) and [color] in the
  /// background. It will stayed for [duration] and automatically hides.
  ///
  /// If [action] is true, a button will appear. The [SnackBar] will
  /// immediately hide on pressed.
  void showSnackBar({
    required String text,
    TextStyle? textStyle,
    Duration? duration,
    Color? color,
    SnackBarAction? action,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    Animation<double>? animation,
    VoidCallback? onVisible,
  }) {
    hideAll();
    final snackBar = SnackBar(
      content: Text(
        text,
        maxLines: customTheme.maxLines,
        overflow: TextOverflow.ellipsis,
        style: textStyle ?? customTheme.textStyle,
      ),
      backgroundColor: color,
      duration: duration ?? customTheme.defaultDuration,
      behavior: behavior,
      animation: animation,
      onVisible: onVisible,
      action: action == null
          ? customTheme.showDefaultAction
              ? SnackBarAction(
                  label: "CLEAR",
                  onPressed: hideAll,
                )
              : null
          : action,
    );
    showRawSnackBar(snackBar);
  }

  /// Show the given [snackBar]
  void showRawSnackBar(SnackBar snackBar) {
    _messengerState.showSnackBar(snackBar);
  }

  /// Immediately hides the [SnackBar]
  void hideAll() {
    _messengerState.removeCurrentSnackBar();
  }
}
