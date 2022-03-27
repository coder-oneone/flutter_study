import 'package:flutter/material.dart';
import 'package:flutter_app/discovery/widget/Banner.dart';
import 'package:flutter_app/discovery/widget/CategoryButton.dart';
import 'package:flutter_app/discovery/widget/RecommendPlayList.dart';

class Discovery extends StatelessWidget {
  Discovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.access_alarm)),
        title: const Text("发现"),
        centerTitle: true,
      ),
      body: const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          DiscoveryBanner(),
          CategoryButton(),
          RecommendPlayListHeader(),
          RecommendPlayListGrid(),
        ],
      ),
    );
  }
}
