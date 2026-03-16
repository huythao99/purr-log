import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'remote_config_service.dart';

class AppOpenAdService with WidgetsBindingObserver {
  final RemoteConfigService _remoteConfigService;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  DateTime? _appOpenLoadTime;

  // Maximum duration allowed between loading and showing the ad (4 hours)
  static const Duration _maxCacheDuration = Duration(hours: 4);

  // Test Ad Unit IDs (Google official test IDs)
  static const String _androidAdUnitId =
      'ca-app-pub-3940256099942544/9257395921';
  static const String _iosAdUnitId = 'ca-app-pub-3940256099942544/5575463023';

  String get _adUnitId => Platform.isAndroid ? _androidAdUnitId : _iosAdUnitId;

  AppOpenAdService({required RemoteConfigService remoteConfigService})
      : _remoteConfigService = remoteConfigService;

  Future<void> initialize() async {
    WidgetsBinding.instance.addObserver(this);
    await loadAd();
  }

  Future<void> loadAd() async {
    // Don't load if ads are disabled
    if (!_remoteConfigService.isAdsEnabled) {
      return;
    }

    // Don't load if already loading or loaded
    if (_appOpenAd != null) {
      return;
    }

    await AppOpenAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenLoadTime = DateTime.now();
        },
        onAdFailedToLoad: (error) {
          // Failed to load, will retry on next app resume
        },
      ),
    );
  }

  bool get _isAdAvailable {
    if (_appOpenAd == null) return false;
    if (_appOpenLoadTime == null) return false;

    // Check if ad has expired (older than 4 hours)
    final timeSinceLoad = DateTime.now().difference(_appOpenLoadTime!);
    if (timeSinceLoad > _maxCacheDuration) {
      _appOpenAd?.dispose();
      _appOpenAd = null;
      return false;
    }

    return true;
  }

  Future<void> showAdIfAvailable() async {
    // Don't show if ads are disabled via Remote Config
    if (!_remoteConfigService.isAdsEnabled) {
      return;
    }

    // Don't show if already showing
    if (_isShowingAd) {
      return;
    }

    // Load ad if not available
    if (!_isAdAvailable) {
      await loadAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        // Preload next ad
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        // Try to load a new ad
        loadAd();
      },
    );

    await _appOpenAd!.show();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh remote config when app resumes
      _remoteConfigService.fetchAndActivate();
      // Show ad when app comes to foreground
      showAdIfAvailable();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _appOpenAd?.dispose();
    _appOpenAd = null;
  }
}
