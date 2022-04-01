import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/commonWidget/CustomSrollViewBar.dart';
import 'package:flutter_app/discovery/playlistSquare.dart';
import 'package:flutter_app/discovery/widget/Banner.dart';
import 'package:flutter_app/discovery/widget/CategoryButton.dart';
import 'package:flutter_app/discovery/widget/NewAlbumAndSound.dart';
import 'package:flutter_app/discovery/widget/RecommendPlayList.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/appstate.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../httpRequest.dart';
import '../viewmodel/album_item.dart';
import '../viewmodel/banneritem.dart';
import '../viewmodel/recommendplaylistitem.dart';
import '../viewmodel/song_item.dart';

class Discovery extends StatefulWidget {
  Discovery({Key? key}) : super(key: key);

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CustomSrollContainer(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.voicemail_rounded)),
              title: const Text("发现"),
              centerTitle: true,
            ),
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () {
                    return _handleRefresh(context);
                  },
                ),
                DiscoveryBanner(),
                CategoryButton(),
                RecommendPlayListHeader(),
                RecommendPlayListGrid(),
                NewAlbumAndSoundHeader(),
                StoreConnector<AppState, bool>(
                  converter: (Store store) => store.state.isShowNewSong,
                  builder: (BuildContext context, bool isShowSong) {
                    return isShowSong ? NewSondGrid() : NewAlbumGrid();
                  },
                  distinct: true,
                ),
              ],
            ),
          ),
        );
      },
      routes: {"/playlistSquare": (BuildContext context) => PlayListSquare()},
    );
  }

  _handleRefresh(BuildContext context) async {
    List respond = await Future.wait([
      httpRequest.get("/banner", queryParameter: {"type": "2"}),
      httpRequest.get("/personalized", queryParameter: {"limit": "6"}),
      httpRequest.get("/album/new", queryParameter: {"limit": 6}),
      httpRequest.get("/top/song", queryParameter: {"type": 0}),
    ]);
    List banners = respond[0]
        .data["banners"]
        .map((banner) => BannerItem(banner["pic"]))
        .toList();
    List list = respond[1]
        .data["result"]
        .map((item) => RecommendPlayListItem(
            id: item["id"],
            palyCount: item["playCount"],
            name: item["name"],
            picUrl: item["picUrl"]))
        .toList();
    List albumList = respond[2]
        .data["albums"]
        .map((album) => AlbumItem(
            id: album["id"],
            picUrl: album["picUrl"],
            name: album["name"],
            artists: (album["artists"] as List)
                .map((item) => ArtistItem(id: item["id"], name: item["name"]))
                .toList()))
        .toList();
    List songList = respond[3]
        .data["data"]
        .sublist(0, 6)
        .map((song) => SongItem(
            id: song["id"],
            picUrl: song["album"]["picUrl"],
            mvId: song["mv"],
            name: song["name"],
            artists: (song["artists"] as List)
                .map((item) =>
                    SongArtistItem(id: item["id"], name: item["name"]))
                .toList()))
        .toList();
    Store<AppState> store = StoreProvider.of<AppState>(context);
    store.dispatch(SetBannersAction(banners));
    store.dispatch(SetRecommendPlayListAction(list));
    store.dispatch(SetAlbumListAction(albumList));
    store.dispatch(SetNewSondListAction(songList));
  }
}
