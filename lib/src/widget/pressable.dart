import 'package:flutter/material.dart';

/// {@template pressable}
/// Can be used to wrap a Widget so that InkWell animation will
/// occur on top of that Widget
/// {@endtemplate}
class Pressable extends Stack {
  /// {@macro pressable}
  Pressable({
    Key key,
    @required Widget child,
    GestureTapCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    InteractiveInkFeatureFactory splashFactory,
    double radius,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
  }) : super(
          key: key,
          children: <Widget>[
            child,
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  onDoubleTap: onDoubleTap,
                  onLongPress: onLongPress,
                  focusColor: focusColor,
                  hoverColor: hoverColor,
                  highlightColor: highlightColor,
                  splashColor: splashColor,
                  splashFactory: splashFactory,
                  radius: radius,
                  borderRadius: borderRadius,
                  customBorder: customBorder,
                ),
              ),
            ),
          ],
        );
}
