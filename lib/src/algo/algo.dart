import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../log.dart';

part 'format_time.dart';
part 'get_ud_id.dart';
part 'to_title_case.dart';

/// Have implemented different types of algorithms that is useful.
abstract class Algo {
  Algo._();

  /// Capitalize the first letters of every words in the given [text].
  /// Words in [text] should be separated with spaces.
  ///
  /// ```dart
  /// final str = "fcode bloc";
  /// final ret = Algo.toTitleCase(str);
  /// print(ret);  // Fcode Bloc
  /// ```
  static String toTitleCase(final String text) => _toTitleCase(text);

  /// Get a unique ID for the flutter app
  static Future<String> getUdID() => _getUdID();

  /// Format the given time by comparing with [DateTime.now()]
  /// and return the time difference in a intelligent format
  ///
  /// ```dart
  /// final d = DateTime()
  /// ```
  ///
  static String formatTime(
    DateTime d, {
    Formatter formatter = Formatter.large,
    bool showAgo = true,
    DateFormat df,
  }) =>
      _formatTime(d, formatter: formatter, showAgo: showAgo, df: df);
}
