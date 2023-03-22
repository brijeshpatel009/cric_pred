import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigUtils {
  static final FirebaseRemoteConfigUtils _configUtils = FirebaseRemoteConfigUtils._internal();

  factory FirebaseRemoteConfigUtils() {
    return _configUtils;
  }

  FirebaseRemoteConfigUtils._internal();

  static const String _admobBannerAdUnitIdKeyName = 'banner_ad_id';
  static const String _admobInterstitialAdUnitIdKeyName = 'interstitial_ad_id';
  static const String _admobRewardedAdUnitIdKeyName = 'reward_ad_id';
  static const String _admobAppOpenAdUnitIdKeyName = 'app_open_ad_id';
  static const String _coolDownsTapsKeyName = 'ad_count';
  static const String _isAdFeatureEnableKeyName = 'is_ads';
  static const String _adDurationPageKeyName = 'page_ad_duration';
  static const String _appVersionKeyName = 'app_version';
  static const String _iosAppUrlKeyName = 'ios_url';
  static const String _androidAppUrlKeyName = 'android_url';
  static const String _privacyPolicyKeyName = 'privacy_policy_url';
  static int rewardedAdCount = 1;

  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static String get admobBannerAdUnitId => _remoteConfig.getString(_admobBannerAdUnitIdKeyName);

  static String get admobInterstitialAdUnitId => _remoteConfig.getString(_admobInterstitialAdUnitIdKeyName);

  static String get admobRewardedAdUnitId => _remoteConfig.getString(_admobRewardedAdUnitIdKeyName);

  static String get admobAppOpenAdUnitId => _remoteConfig.getString(_admobAppOpenAdUnitIdKeyName);

  static String get isoAppUrl => _remoteConfig.getString(_iosAppUrlKeyName);

  static String get androidAppUrl => _remoteConfig.getString(_androidAppUrlKeyName);

  static String get newVersion => _remoteConfig.getString(_appVersionKeyName);

  static String get privacyPolicyUrl => _remoteConfig.getString(_privacyPolicyKeyName);

  static int get coolDownsTaps => _remoteConfig.getInt(_coolDownsTapsKeyName);

  static int get adPageDuration => _remoteConfig.getInt(_adDurationPageKeyName);

  static bool get isAdFeatureEnable => _remoteConfig.getBool(_isAdFeatureEnableKeyName);

  Future<void> initMethod() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(fetchTimeout: const Duration(minutes: 1), minimumFetchInterval: const Duration(seconds: 0)),
    );
    await _remoteConfig.fetchAndActivate();
  }
}
