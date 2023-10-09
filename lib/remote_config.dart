import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;

  String get themeCode =>
      _remoteConfig.getString(FirebaseRemoteConfigKeys.themeCode);
  // String get fontSize => _remoteConfig.getString(FirebaseRemoteConfigKeys.fontSize);
  String get title => _remoteConfig.getString(FirebaseRemoteConfigKeys.title);
   String get image => _remoteConfig.getString(FirebaseRemoteConfigKeys.image);
   String get remoteTextStyle => _remoteConfig.getString(FirebaseRemoteConfigKeys.remoteTextStyle.toString());
  // String get defaultTextStyle => _remoteConfig.getString(FirebaseRemoteConfigKeys.defaultTextStyle.toString());

  static FirebaseRemoteConfigService? _instance;

  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 10),
        ),
      );

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      debugPrint('The config has been updated.');
    } else {
      debugPrint('The config is not updated..');
    }
  }

  Future<void> initialize() async {
    await _setConfigSettings();
    await fetchAndActivate();


  }
}

class FirebaseRemoteConfigKeys {
  double fontSize = 20;

  static FirebaseRemoteConfig  remoteConfig = FirebaseRemoteConfig.instance;
  static const String themeCode = 'theme_mode';static const String title = 'title';
  static const String image = 'Image';
  static const String color = 'title_color';

  static  TextStyle remoteTextStyle = TextStyle(
    fontSize: remoteConfig.getDouble('font_size'),
    color: Color(remoteConfig.getInt('title_color')),
    // Other text style properties from remote config
  );


}

