import 'package:flutter/material.dart';
import 'package:flutter_app/commonWidget/CustomBackButton.dart';
import 'package:flutter_app/discovery/widget/PlayListView.dart';
import 'package:flutter_app/httpRequest.dart';
import 'package:flutter_app/viewmodel/play_list_tag.dart';

class PlayListSquare extends StatefulWidget {
  PlayListSquare({Key? key}) : super(key: key);

  @override
  State<PlayListSquare> createState() => _PlayListSquareState();
}

class _PlayListSquareState extends State<PlayListSquare> {
  List _hotPlayListCategory = [];
  @override
  void initState() {
    httpRequest.get("/playlist/hot").then((value) {
      setState(() {
        _hotPlayListCategory = value.data["tags"]
            .map((tag) => PlayListTag(id: tag["id"], name: tag["name"]))
            .toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_hotPlayListCategory.length > 0) {
      return DefaultTabController(
          length: _hotPlayListCategory.length,
          child: Scaffold(
            appBar: AppBar(
              leading: CustomBackButton(),
              title: const Text("歌单广场"),
              centerTitle: true,
              elevation: 1.0,
              bottom: PreferredSize(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TabBar(
                      isScrollable: true,
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: _hotPlayListCategory
                          .map((item) => Tab(
                                text: item.name,
                              ))
                          .toList(),
                    )),
                    const Icon(Icons.menu),
                  ],
                ),
                preferredSize: const Size.fromHeight(40),
              ),
            ),
            body: TabBarView(
                children: _hotPlayListCategory
                    .map((item) => PlaylistView(
                          cat: item.name,
                        ))
                    .toList()),
          ));
    } else {
      return Container();
    }
  }
}
