import 'package:flutter/material.dart';
import 'package:flutter_app/commonWidget/CustomPlayListItem.dart';
import 'package:flutter_app/commonWidget/CustomSliverGrid.dart';
import 'package:flutter_app/commonWidget/CustomSrollViewBar.dart';
import 'package:flutter_app/commonWidget/LoadMore.dart';
import 'package:flutter_app/httpRequest.dart';
import 'package:flutter_app/viewmodel/recommendplaylistitem.dart';

class PlaylistView extends StatefulWidget {
  final String cat;
  PlaylistView({required this.cat});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView>
    with AutomaticKeepAliveClientMixin {
  final List _playList = [];
  bool _hasMore = true;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _getPlayList();
    _scrollController.addListener(() {
      if (_hasMore &&
          (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) &&
          !_isLoading) {
        _isLoading = true;
        _getPlayList(_playList.length);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomSrollContainer(
        child: CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: CustomSliverGrid(
              childer: _playList
                  .map((item) => CustomPlayListItem(
                      name: item.name,
                      picUrl: item.picUrl,
                      palyCount: item.palyCount,
                      id: item.id))
                  .toList()),
        ),
        LoadMore(
          noMore: !_hasMore,
        )
      ],
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  _getPlayList([int offset = 0]) {
    httpRequest.get("/top/playlist", queryParameter: {
      "cat": widget.cat,
      "limit": 21,
      "offset": offset
    }).then((value) {
      var data = value.data;
      setState(() {
        _playList.addAll(data["playlists"]
            .map((item) => RecommendPlayListItem(
                id: item["id"],
                name: item["name"],
                palyCount: item["playCount"],
                picUrl: item["coverImgUrl"]))
            .toList());
        _hasMore = data["more"];
        _isLoading = false;
      });
    });
  }
}
