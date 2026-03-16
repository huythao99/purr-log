import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  // Remote config keys
  static const String _adsEnabledKey = 'ads_enabled';

  // Default values
  static const bool _defaultAdsEnabled = false;

  RemoteConfigService({FirebaseRemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    // Set default values
    await _remoteConfig.setDefaults({
      _adsEnabledKey: _defaultAdsEnabled,
    });

    // Configure settings
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    // Fetch and activate on initialization
    await fetchAndActivate();
  }

  Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      // Silently fail - will use default/cached values
    }
  }

  bool get isAdsEnabled => _remoteConfig.getBool(_adsEnabledKey);
}
