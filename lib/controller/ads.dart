import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ads {
  InterstitialAd? interstitialAd;
  AppOpenAd? openAd;

  // void loadIntertial()   {
  //     InterstitialAd.load(
  //       adUnitId: "ca-app-pub-3940256099942544/1033173712",
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
  //         interstitialAd = ad;
  //         interstitialAd!.show();
  //       }, onAdFailedToLoad: (ad) {
  //         interstitialAd!.dispose();
  //       }));
  // }

  bool isInterstitialLoaded = false;
//InterstitialAd? interstitialAd;

  Future<void> loadIntertial() async {
    if (!isInterstitialLoaded) {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool cache = prefs.getBool('interstitial_loaded') ?? false;
    if (cache && interstitialAd != null) {
      interstitialAd!.show();
      return;
    }

      await InterstitialAd.load(
          adUnitId: "ca-app-pub-3940256099942544/1033173712",
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
            interstitialAd = ad;
            isInterstitialLoaded = true;
            prefs.setBool('interstitial_loaded', true);
            interstitialAd!.show();
          }, onAdFailedToLoad: (ad) {
            interstitialAd!.dispose();
          }));
    } else {
      interstitialAd!.show();
    }
  }

  Future<void> loadopenad() async {
    await AppOpenAd.load(
        adUnitId: "ca-app-pub-3940256099942544/3419835294",
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
          print("Open Ad Loaded");
          openAd = ad;
          openAd!.show();
        }, onAdFailedToLoad: (ad) {
          print("Open ad failed");
          openAd!.dispose();
        }),
        orientation: AppOpenAd.orientationPortrait);
  }

  // Future storevalue() async {
  //   int clickcount = 3;

  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   int count = pref.getInt("count") == null ? 0 : pref.getInt("count")!;
  //   pref.setInt("count", count);
  //   if (pref.getInt('count')! < clickcount) {
  //     pref.setInt("count", pref.getInt('count')! + 1);
  //     print("added to " + pref.getInt('count')!.toString());
  //   } else if ((pref.getInt('count')!) == clickcount) {
  //     loadIntertial();
  //     print("Ad Block");
  //     pref.setInt("count", 0);
  //   } else {
  //     print("Seted to 0");
  //     pref.setInt("count", 0);
  //   }
  // }

  Map<String, int> cache = {};

  Future<void> storevalue() async {
    int clickCount = 3;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = cache['count'] ?? prefs.getInt('count') ?? 0;
    cache['count'] = count;
    if (cache['count']! < clickCount) {
      cache['count'] = cache['count']! + 1;
      prefs.setInt('count', cache['count']!);
      print('Added to ${cache['count']}');
    } else if (cache['count'] == clickCount) {
      loadIntertial();
      print('Ad block');
      cache['count'] = 0;
      prefs.setInt('count', cache['count']!);
    } else {
      print('Set to 0');
      cache['count'] = 0;
      prefs.setInt('count', cache['count']!);
    }
  }
}
