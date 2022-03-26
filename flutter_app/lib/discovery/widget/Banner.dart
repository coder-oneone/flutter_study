import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/httpRequest.dart';
import 'package:flutter_app/viewmodel/banneritem.dart';

class DiscoveryBanner extends StatefulWidget {
  const DiscoveryBanner({Key? key}) : super(key: key);

  @override
  State<DiscoveryBanner> createState() => _DiscoveryBannerState();
}

class _DiscoveryBannerState extends State<DiscoveryBanner> {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentIndex = 1;
  late Timer _timer;
  List _banners = [];
  List _addBanners = [];

  @override
  void initState() {
    httpRequest.get("/banner", queryParameter: {"type": "2"}).then((response) {
      List banners = response.data["banners"]
          .map((banner) => BannerItem(banner["pic"]))
          .toList();
      setState(() {
        List addedBanners = [];
        addedBanners
          ..add(banners[banners.length - 1])
          ..addAll(banners)
          ..add(banners[0]);
        _banners = banners;
        _addBanners = addedBanners;
      });
      _setTimer();
    });
    super.initState();
  }

// 设置定时器
  _setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      _pageController.animateToPage(_currentIndex + 1,
          duration: const Duration(milliseconds: 400), curve: Curves.bounceIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 2.5,
        child: Stack(
          children: [
            NotificationListener(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (page) {
                  int newIndex;
                  if (page == _addBanners.length - 1) {
                    newIndex = 1;
                    _pageController.jumpToPage(newIndex);
                  } else if (page == 0) {
                    newIndex = _addBanners.length - 2;
                    _pageController.jumpToPage(newIndex);
                  } else {
                    newIndex = page;
                  }
                  setState(() {
                    _currentIndex = newIndex;
                  });
                },
                children: _addBanners
                    .map((item) => Container(
                          margin: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              item.pic,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              onNotification: (ScrollNotification startNotification) {
                if (startNotification.depth == 0 &&
                    // ignore: unnecessary_type_check
                    startNotification is ScrollStartNotification) {
                  if (startNotification.dragDetails != null) {
                    _timer.cancel();
                    return true;
                  }
                } else if (startNotification is ScrollEndNotification) {
                  _timer.cancel();
                  _setTimer();
                  return false;
                }
                return true;
              },
            ),
            Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _banners
                      .asMap()
                      .map((key, value) => MapEntry(
                          key,
                          Container(
                            width: 6,
                            height: 6,
                            margin:
                                const EdgeInsets.only(left: 2.0, right: 2.0),
                            decoration: BoxDecoration(
                                color: _currentIndex == key + 1
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                shape: BoxShape.circle),
                          )))
                      .values
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
