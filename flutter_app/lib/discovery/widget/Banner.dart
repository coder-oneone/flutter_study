import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/httpRequest.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/appstate.dart';
import 'package:flutter_app/viewmodel/banneritem.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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

// 设置定时器
  _setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      _pageController.animateToPage(_currentIndex + 1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_banners.isNotEmpty) {
      return SliverToBoxAdapter(
        child: AspectRatio(
            aspectRatio: 2.5,
            child: StoreConnector<AppState, List>(
              distinct: true,
              converter: (Store store) => store.state.banners,
              builder: (BuildContext context, List banner) {
                return Stack(
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
                          }
                        } else if (startNotification is ScrollEndNotification) {
                          _timer.cancel();
                          _setTimer();
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
                                    margin: const EdgeInsets.only(
                                        left: 2.0, right: 2.0),
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
                );
              },
              onInit: (Store store) {
                httpRequest.get("/banner", queryParameter: {"type": "2"}).then(
                    (response) {
                  List banners = response.data["banners"]
                      .map((banner) => BannerItem(banner["pic"]))
                      .toList();
                  List addedBanners = [];
                  addedBanners
                    ..add(banners[banners.length - 1])
                    ..addAll(banners)
                    ..add(banners[0]);
                  _banners = banners;
                  _addBanners = addedBanners;
                  store.dispatch(SetBannersAction(banners));
                  _setTimer();
                });
              },
            )),
      );
    } else {
      return SliverToBoxAdapter();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
