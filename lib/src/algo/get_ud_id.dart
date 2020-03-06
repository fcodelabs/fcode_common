part of 'algo.dart';

String _deviceID;
final _log = Log("Algorithms");

Future<String> _getUdID() async {
  if (_deviceID == null || _deviceID.isEmpty) {
    var deviceName = "";
    var deviceVersion = "";
    var identifier = "";
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;
      }
    } on PlatformException {
      _log.e('Failed to get platform version');
    }
    _log.i(
      'Device Name: $deviceName, '
      'deviceVersion: $deviceVersion, '
      'identifier: $identifier',
    );

    final key = identifier;
    _deviceID = sha512.convert(utf8.encode(key)).toString();
  }
  return _deviceID;
}
