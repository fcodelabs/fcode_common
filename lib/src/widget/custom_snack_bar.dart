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

  /// Shows a SnackBar with given error [msg]
  void showErrorSnackBar(String msg) {
    showSnackBar(text: "Error: $msg", color: Colors.red[300]);
  }

  ScaffoldState get _state {
    return scaffoldKey == null ? scaffoldState : scaffoldKey.currentState;
  }

  /// Show a Loading SnackBar for 1 minute
  void showLoadingSnackBar() {
    hideAll();
    final snackBar = SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 10.0),
          Text("Loading..."),
        ],
      ),
      backgroundColor: Colors.green[300],
      duration: Duration(minutes: 1),
    );
    _state?.showSnackBar(snackBar);
  }

  /// Show a [SnackBar] with [text] (maximum 2 lines) and [color] in the
  /// background. It will stayed for [duration] and automatically hides.
  ///
  /// If [action] is true, a button will appear. The [SnackBar] will
  /// immediately hide on pressed.
  void showSnackBar({
    @required String text,
    Duration duration = const Duration(hours: 1),
    Color color,
    bool action = true,
  }) {
    assert(action != null);
    assert(duration != null);
    hideAll();
    final snackBar = SnackBar(
      content: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: color ?? Colors.green[400],
      duration: duration,
      action: action
          ? SnackBarAction(
              label: "Clear",
              textColor: Colors.black,
              onPressed: () => _state.removeCurrentSnackBar(),
            )
          : null,
    );
    _state?.showSnackBar(snackBar);
  }

  /// Immediately hides the [SnackBar]
  void hideAll() {
    _state?.removeCurrentSnackBar();
  }
}
