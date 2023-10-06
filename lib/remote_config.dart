

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._() : _remoteConfig = FirebaseRemoteConfig.instance;

  String get welcomeMessage => _remoteConfig.getString(FirebaseRemoteConfigKeys.welcomeMessage);

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() => _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
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
  static const String welcomeMessage = 'theme_mode';
}

