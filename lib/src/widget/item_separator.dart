import 'package:flutter/material.dart';

/// {@template item_separator}
/// A line with height 1 that can be used as a separator.
///
/// Don't put [Padding] manually. Padding can be adjusted by changing
/// the value of [lineSize].
/// {@endtemplate}
class ItemSeparator extends StatelessWidget {
  /// Large line that will be equal to the width of the screen
  // ignore: constant_identifier_names
  static const LINE_LARGE = 0;

  /// Line with 16 width padding from the start
  // ignore: constant_identifier_names
  static const LINE_MEDIUM = 1;

  /// Line with 80 width padding from the start
  // ignore: constant_identifier_names
  static const LINE_SMALL = 2;

  /// Size of the line. Pre-defined sizes can be obtained using
  /// [LINE_LARGE], [LINE_MEDIUM] or [LINE_SMALL].
  ///
  /// When [lineSize] >= 3, that line will have the exact same padding
  /// from the start, instead of the pre-defined values.
  final int lineSize;

  /// Color to be shown in the padding area. App's `backgroundColor`
  /// is used if not provided.
  final Color backgroundColor;

  /// Color of the line.
  final Color separatorColor;

  /// {@macro item_separator}
  ItemSeparator({
    Key key,
    this.lineSize = LINE_LARGE,
    this.backgroundColor,
    this.separatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      color: backgroundColor ?? themeData.backgroundColor,
      child: Container(
        height: 1,
        width: double.infinity,
        margin: EdgeInsets.only(
          left: lineSize == LINE_MEDIUM
              ? 16
              : lineSize == LINE_SMALL
                  ? 80
                  : lineSize == LINE_LARGE
                      ? 0
                      : lineSize.toDouble(),
        ),
        color: separatorColor ?? const Color(0x90D1D1D1),
      ),
    );
  }
}
