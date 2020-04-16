import 'package:flutter/material.dart';

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

  /// {@macro custom_snack_bar}
  const CustomSnackBar({this.scaffoldKey, this.scaffoldState})
      : assert(scaffoldState != null || scaffoldKey != null);

  ScaffoldState get _state {
    return scaffoldKey == null ? scaffoldState : scaffoldKey.currentState;
  }

  /// Shows a SnackBar with given error [msg]
  void showErrorSnackBar(String msg, {
    Color backgroundColor,
    Duration duration,
  }) {
    backgroundColor ??= Colors.red[300];
    duration ??= Duration(hours: 1);
    showSnackBar(
      text: "Error: $msg",
      color: backgroundColor,
      duration: duration,
    );
  }

  /// Show a Loading SnackBar for 1 minute
  void showLoadingSnackBar({Color backgroundColor, Duration duration}) {
    hideAll();
    backgroundColor ??= Colors.green[300];
    duration ??= Duration(minutes: 1);
    final snackBar = SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 10.0),
          Text("Loading..."),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
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
    Duration duration = const Duration(seconds: 5),
    Color color,
    SnackBarAction action,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
  }) {
    assert(duration != null);
    hideAll();
    final snackBar = SnackBar(
      content: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: color,
      duration: duration,
      behavior: behavior,
      action: action ??
          SnackBarAction(
            label: "CLEAR",
            onPressed: hideAll,
          ),
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
