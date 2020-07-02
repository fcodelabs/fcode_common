part of 'algo.dart';

String _deviceID;
String _deviceName;
String _deviceVersion;
final _log = Log("Algorithms");

Future<void> __findDeviceInfo() async {
  var identifier = "";
  final deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final build = await deviceInfoPlugin.androidInfo;
      _deviceName = build.model;
      _deviceVersion = build.version.toString();
      identifier = build.androidId;
    } else if (Platform.isIOS) {
      final data = await deviceInfoPlugin.iosInfo;
      _deviceName = data.name;
      _deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor;
    }
  } on PlatformException {
    _log.e('Failed to get platform version');
  }
  _log.i(
    'Device Name: $_deviceName, '
    'deviceVersion: $_deviceVersion, '
    'identifier: $identifier',
  );

  final key = identifier;
  _deviceID = sha512.convert(utf8.encode(key)).toString();
}

Future<String> _getUdID() async {
  if (_deviceID?.isEmpty ?? true) {
    await __findDeviceInfo();
  }
  return _deviceID;
}

Future<String> _getDeviceName() async {
  if (_deviceName?.isEmpty ?? true) {
    await __findDeviceInfo();
  }
  return _deviceName;
}

Future<String> _getDeviceVersion() async {
  if (_deviceVersion?.isEmpty ?? true) {
    await __findDeviceInfo();
  }
  return _deviceVersion;
}
