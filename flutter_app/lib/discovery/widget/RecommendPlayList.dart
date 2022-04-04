import 'package:flutter/material.dart';
import 'package:flutter_app/commonWidget/CustomPlayListItem.dart';
import 'package:flutter_app/commonWidget/CustomSliverGrid.dart';
import 'package:flutter_app/httpRequest.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/appstate.dart';
import 'package:flutter_app/viewmodel/recommendplaylistitem.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../redux/models.dart';
import '../../viewmodel/song_item.dart';

class RecommendPlayListHeader extends StatelessWidget {
  const RecommendPlayListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "推荐歌单",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: const Text(
                  "歌单广场",
                  style: TextStyle(fontSize: 12.0),
                ),
                decoration: ShapeDecoration(
                    shape: StadiumBorder(
                        side:
                        BorderSide(color: Theme
                            .of(context)
                            .dividerColor))),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendPlayListGrid extends StatelessWidget {
  const RecommendPlayListGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List>(
      distinct: true,
      converter: (Store store) => store.state.recommendPlayList,
      builder: (BuildContext context, List recommendPlayList) {
        return SliverPadding(
          padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
          sliver: CustomSliverGrid(
              childer: recommendPlayList
                  .map((item) =>
                  CustomPlayListItem(
                      name: item.name,
                      picUrl: item.picUrl,
                      palyCount: item.palyCount,
                      id: item.id))
                  .toList()),
        );
      },
      onInit: (Store store) {
        httpRequest.get("/personalized", queryParameter: {"limit": "6"}).then(
                (respond) {
              List list = respond.data["result"]
                  .map((item) =>
                  RecommendPlayListItem(
                      id: item["id"],
                      palyCount: item["playCount"],
                      name: item["name"],
                      picUrl: item["picUrl"]))
                  .toList();

              if (store.state.playListModel.songList.isEmpty) {
                httpRequest.get("/playlist/detail",
                    queryParameter: {"id": respond.data["result"][0]["id"]})
                    .then((value) {
                  PlayListModel playListModel = PlayListModel(
                      id: value.data["playlist"]["id"],
                      songList: (value.data["playlist"]["tracks"] as List).map((
                          song) =>
                          SongItem(
                              id: song["id"],
                              mvId: song["mv"],
                              picUrl: song["al"]["picUrl"],
                              name: song["name"],
                              artists: (song["ar"] as List)
                                  .map((item) =>
                                  SongArtistItem(
                                      id: item["id"], name: item["name"]))
                                  .toList()))
                          .toList()
                  );
                  store.dispatch(SetPalyListModelAction(playListModel));
                });
              }
              store.dispatch(SetRecommendPlayListAction(list));
            });
      },
    );
  }
}
