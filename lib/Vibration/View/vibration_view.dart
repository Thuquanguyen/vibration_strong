import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/Ads/ad_manager.dart';
import 'package:flutter_app_vibrator_strong/View/AlertView/alert_setup_time.dart';
import 'package:vibration/vibration.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class VibrationView extends StatefulWidget {
  @override
  _VibrationViewState createState() => _VibrationViewState();
}

class _VibrationViewState extends State<VibrationView> {
  var isStart = true;
  var isLook = false;
  int miliSecond = 0;

  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  int check = 1;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdManager.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Icon(
                isStart
                    ? Icons.play_circle_outline
                    : Icons.pause_circle_outline,
                size: 150),
            onTap: () {
              if (isStart) {
                List<int> patterns = <int>[];
                for (int i = 0; i < (miliSecond / 100); i++) {
                  patterns.add(100);
                  patterns.add(50);
                }
                print("pattern : $patterns");
                Vibration.vibrate(
                  pattern: patterns,
                );
              } else {
                setState(() {
                  check = check + 1;
                });
                if (check % 3 == 0) {
                  _loadInterstitialAd();
                }
                if (_isInterstitialAdReady) {
                  _interstitialAd?.show();
                }
                Vibration.cancel();
                print("caa");
              }
              setState(() {
                isStart = !isStart;
                print("start : $isStart");
              });
            },
          ),
          Text("${isStart ? "Start" : "Running"}"),
          SizedBox(height: 50),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    if (!isLook) {
                      _showAlert(context, (milisecond) {
                        setState(() {
                          miliSecond = milisecond.toInt();
                        });
                      });
                    }
                  },
                  child: Text(
                    "Time",
                    style:
                        TextStyle(color: isLook ? Colors.grey : Colors.black),
                  ),
                  // color: isLook ? Colors.greenAccent : Colors.green
              ),
              SizedBox(
                width: 50,
              ),
              GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLook = !isLook;
                    });
                    if (isLook) {
                      setState(() {
                        miliSecond = miliSecond * 10;
                      });
                    } else {
                      setState(() {
                        miliSecond = miliSecond ~/ 10;
                      });
                    }
                  },
                  child: Text(
                    "${isLook ? "Unlock" : "Lock"}",
                    style: TextStyle(color: Colors.black),
                  ),
                  // color: Colors.green
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      )),
    );
  }
}

void _showAlert(BuildContext context, Function(double milisecond) timeChange) {
  AlertDialog dialog = new AlertDialog(
    content: new Container(
      width: 260.0,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xFFFFFF),
        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
      ),
      child: AlertSetuptime(
        changeTime: (second, minute) {
          timeChange((minute * 60 + second) * 1000);
        },
      ),
    ),
  );

  showDialog(context: context, builder: (BuildContext context) => dialog);
}
