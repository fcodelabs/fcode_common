import 'package:flutter/material.dart';

import 'custom_snack_bar_theme.dart';

/// {@template custom_snack_bar}
/// Create a [SnackBar] directly from a [scaffoldKey] or a [scaffoldState].
///
/// Provide one which is associated with the [Scaffold] which is used
/// to show the [SnackBar]. If both are provided, [scaffoldKey] will have
/// the priority.
/// {@endtemplate}
class CustomSnackBar {
  /// [scaffoldKey] which is associate with the [Scaffold]
  final GlobalKey<ScaffoldState> scaffoldKey;

  /// [scaffoldState] which is associate with the [Scaffold]
  final ScaffoldState scaffoldState;

  /// Additional theme information for [CustomSnackBar]
  static CustomSnackBarTheme customTheme = CustomSnackBarTheme();

  /// {@macro custom_snack_bar}
  const CustomSnackBar({this.scaffoldKey, this.scaffoldState})
      : assert(scaffoldState != null || scaffoldKey != null);

  ScaffoldState get _state {
    return scaffoldKey == null ? scaffoldState : scaffoldKey.currentState;
  }

  /// Shows a SnackBar with given error [msg]
  void showErrorSnackBar(
    String msg, {
    Color backgroundColor,
    Duration duration,
  }) {
    showSnackBar(
      text: "Error: $msg",
      textStyle: customTheme.errorSnackBarTextStyle,
      color: backgroundColor ?? customTheme.errorSnackBarColor,
      duration: duration ?? customTheme.errorSnackBarDuration,
    );
  }

  /// Show a Loading SnackBar for 1 minute
  void showLoadingSnackBar({Color backgroundColor, Duration duration}) {
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
    @required String text,
    TextStyle textStyle,
    Duration duration,
    Color color,
    SnackBarAction action,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    Animation<double> animation,
    VoidCallback onVisible,
  }) {
    assert(duration != null);
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
      action: action == null && customTheme.showDefaultAction
          ? SnackBarAction(
              label: "CLEAR",
              onPressed: hideAll,
            )
          : null,
    );
    showRawSnackBar(snackBar);
  }

  /// Show the given [snackBar]
  void showRawSnackBar(SnackBar snackBar) {
    _state?.showSnackBar(snackBar);
  }

  /// Immediately hides the [SnackBar]
  void hideAll() {
    _state?.removeCurrentSnackBar();
  }
}
