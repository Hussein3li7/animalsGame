import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdmobService {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['child', 'Kids', 'game', 'animals'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: getBannerAdUnitId(),
    size: AdSize.banner,
    targetingInfo: targetingInfo,
  );

  InterstitialAd myInterstitial = InterstitialAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: getInterstitialAdUnitId(),
    targetingInfo: targetingInfo,
  );

  String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-4463119466252038~5588270112';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-4463119466252038~7643108883';
    }
    return null;
  }

  static String getBannerAdUnitId() {
    // banner Ads Id
    if (Platform.isIOS) {
      return 'ca-app-pub-4463119466252038/4605882003';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-4463119466252038/4929794563';
    }
    return null;
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-4463119466252038/1788146975';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-4463119466252038/4111536916';
    }
    return null;
  }
}
