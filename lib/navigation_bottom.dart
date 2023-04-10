import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/More/View/more_view.dart';
import 'package:flutter_app_vibrator_strong/Setting/View/setting_view.dart';
import 'package:flutter_app_vibrator_strong/Vibration/View/vibration_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Ads/ad_manager.dart';

class NavigationBottomBar extends StatefulWidget {
  static const routeName = '/navigation-bar';

  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  // TODO: Add _bannerAd
  late BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  final List<Widget> _pages = <Widget>[
    VibrationView(),
    SettingView(),
    MoreView()
//    AdmodView()
  ];

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(label: "Vibration", icon: Icon(Icons.vibration)),
    BottomNavigationBarItem(label: "Setting", icon: Icon(Icons.settings)),
    BottomNavigationBarItem(label: "More", icon: Icon(Icons.more_horiz)),
  ]; // Cre

  final PageStorageBucket _bucket = PageStorageBucket();

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: SafeArea(
        child: Column(
          children: [
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
            Expanded(child: PageStorage(bucket: _bucket, child: IndexedStack(children: _pages, index: _selectedIndex))),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
      onTap: (int index) {
        setState(() => _selectedIndex = index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color.fromRGBO(39, 65, 143, 1),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      items: _items);
}
