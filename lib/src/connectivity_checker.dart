import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template connectivity_checker}
/// Can be used to check whether there is internet connection to this
/// device or not.
///
/// This simply send periodic signals to a given [domain] and if the requests
/// were sent successfully this will add [true] to the [stream]. If connection
/// was unsuccessful, this will add [false] to the [stream].
///
/// Make sure to call [close] after using this instance.
/// {@endtemplate}
class ConnectivityChecker {
  final _stream = BehaviorSubject<bool>();

  /// Refresh rate of the [Timer] in seconds. Default is 10 seconds.
  final int refresh;

  /// Requests will be sent to this domain to check the availability
  /// of the internet. Default is example.com
  final String domain;

  /// Check whether the [Timer] is started or not. Once the [Timer] is started,
  /// it cannot be stopped without calling [close].
  bool started = false;

  Timer _timer;
  bool _last;

  /// {@macro connectivity_checker}
  ConnectivityChecker({
    this.refresh = 10,
    this.domain = 'example.com',
  });

  /// You have to call this method to start the [Timer]. You cannot use the
  /// [stream] without calling this function.
  ///
  /// Multiple calls for this function has no effect.
  void start() {
    if (started) {
      return;
    }
    restart();
  }

  /// Same is [start], but this will restart the [Timer] every time this is
  /// called.
  void restart() {
    _timer?.cancel();
    _last = null;
    _timer = Timer.periodic(Duration(seconds: refresh), (t) async {
      try {
        final result = await InternetAddress.lookup(domain);
        if (result.isNotEmpty &&
            result[0].rawAddress.isNotEmpty &&
            !(_last ?? false)) {
          _stream.add(true);
          _last = true;
        }
      } on SocketException catch (_) {
        if (_last ?? true) {
          _stream.add(false);
          _last = false;
        }
      }
    });
    started = true;
  }

  /// Must call this method after using this instance. This method will
  /// close the [Timer] and release any resources that this holds.
  @mustCallSuper
  Future<void> close() async {
    _timer?.cancel();
    await _stream.close();
  }

  /// Get the stream associated with this instance. You can use this stream
  /// to listen to the changes in the internet connection.
  ///
  /// This will emmit [true] is internet connection came live and [false]
  /// if internet is offline.
  ///
  /// You must start call [start] or [restart] before using the stream.
  Stream<bool> get stream {
    if (!started) {
      throw "Call the method start() before using the stream";
    }
    return _stream;
  }
}
