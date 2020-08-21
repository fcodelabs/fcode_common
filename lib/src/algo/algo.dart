import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../log.dart';

part 'change_case.dart';
part 'format_time.dart';
part 'get_ud_id.dart';

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

  /// Capitalize the first letter of the given [text]
  ///
  /// ```dart
  /// final str = "fcode bloc";
  /// final ret = Algo.toFirstLetterCapital(str);
  /// print(ret);  // Fcode bloc
  /// ```
  static String toFirstLetterCapital(final String text) =>
      _firstLetterCapital(text);

  /// Capitalize the first letter of each sentence of the given [text]
  ///
  /// ```dart
  /// final str = "i walk down. i look up.";
  /// final ret = Algo.toFirstLetterCapital(str);
  /// print(ret);  // I walk down. I look up.
  /// ```
  static String toSentenceCapital(final String text) => _sentenceCapital(text);

  /// Get a unique ID for the flutter app
  static Future<String> getUdID() => _getUdID();

  /// Get the name of the device which was given by the hardware
  /// manufacturer.
  static Future<String> getDeviceName() => _getDeviceName();

  /// Version of the current operating system.
  static Future<String> getDeviceVersion() => _getDeviceVersion();

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
      _formatTime(
        d,
        formatter: formatter,
        showAgo: showAgo,
        df: df,
      );
}
