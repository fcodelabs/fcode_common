import 'dart:async';

import 'package:flutter/material.dart';

import '../algo/algo.dart';

/// {@template past_time}
/// Create a widget that will show the given [dateTime] after formatting
/// with [Algo.formatTime]
/// {@endtemplate}
class PastTime extends StatefulWidget {
  /// DateTime that is needed to be shown with respect to the
  /// current time
  final DateTime dateTime;

  /// Text Style of the field
  final TextStyle style;

  /// Text Alignment of the field
  final TextAlign textAlign;

  /// {@macro past_time}
  PastTime({
    Key key,
    @required this.dateTime,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  _PastTimeState createState() => _PastTimeState();
}

class _PastTimeState extends State<PastTime> {
  Timer timer;
  bool showFirst;
  String first;
  String second;

  @override
  void initState() {
    super.initState();
    showFirst = true;
    timer = Timer.periodic(Duration(seconds: 60), changeValues);
    first = widget.dateTime == null ? "" : Algo.formatTime(widget.dateTime);
    second = first;
  }

  void changeValues(Timer t) {
    if (showFirst) {
      second = widget.dateTime == null ? "" : Algo.formatTime(widget.dateTime);
    } else {
      first = widget.dateTime == null ? "" : Algo.formatTime(widget.dateTime);
    }
    showFirst = !showFirst;
    if (mounted) {
      setState(() {});
    }
  }

  Widget generateText(String text) {
    return Text(
      text,
      style: widget.style,
      textAlign: widget.textAlign,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: generateText(first),
      secondChild: generateText(second),
      duration: Duration(milliseconds: 500),
      crossFadeState:
          showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}