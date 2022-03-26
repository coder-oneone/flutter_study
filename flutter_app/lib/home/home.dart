import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../account/account.dart';
import '../discovery/discovery.dart';
import '../friends/friend.dart';
import '../mine/mine.dart';
import '../video/video.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final List<BottomNavigationBarItem> _tabs = [
    const BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "发现"),
    const BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "视频"),
    const BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "我的"),
    const BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "朋友"),
    const BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "账号"),
  ];
  final List<Widget> _pages = [
    Discovery(),
    Video(),
    Mine(),
    Friends(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    // BottomNavigationBarItem(icon: Icon(tab["icon"]), label: tab["text"])
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Theme.of(context).primaryColor,
          items: _tabs,
        ),
        tabBuilder: (BuildContext context, int index) {
          return _pages[index];
        });
  }
}
