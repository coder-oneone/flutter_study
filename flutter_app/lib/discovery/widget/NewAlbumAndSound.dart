import 'package:flutter/material.dart';
import 'package:flutter_app/commonWidget/CustomSliverGrid.dart';
import 'package:flutter_app/httpRequest.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/appstate.dart';
import 'package:flutter_app/viewmodel/album_item.dart';
import 'package:flutter_app/viewmodel/song_item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class NewAlbumAndSoundHeader extends StatelessWidget {
  const NewAlbumAndSoundHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StoreConnector<AppState, bool>(
                    distinct: true,
                    converter: (Store store) => store.state.isShowNewSong,
                    builder: (BuildContext context, bool isShowNewSong) {
                      return GestureDetector(
                        onTap: () {
                          StoreProvider.of<AppState>(context)
                              .dispatch(SetShowNewSondAction(false));
                        },
                        child: Text(
                          "新碟",
                          style: TextStyle(
                              fontSize: isShowNewSong ? 14.0 : 16.0,
                              color:
                                  isShowNewSong ? Colors.grey : Colors.black),
                        ),
                      );
                    }),
                Container(
                  // color: Colors.red,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: 2.0,
                  child: const Text(
                    " | ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                StoreConnector<AppState, bool>(
                    distinct: true,
                    converter: (Store store) => store.state.isShowNewSong,
                    builder: (BuildContext context, bool isShowNewSong) {
                      return GestureDetector(
                        onTap: () {
                          StoreProvider.of<AppState>(context)
                              .dispatch(SetShowNewSondAction(true));
                        },
                        child: Text(
                          "新歌",
                          style: TextStyle(
                              fontSize: isShowNewSong ? 16.0 : 14.0,
                              color:
                                  isShowNewSong ? Colors.black : Colors.grey),
                        ),
                      );
                    }),
              ],
            ),
            StoreConnector<AppState, bool>(
                distinct: true,
                converter: (Store store) => store.state.isShowNewSong,
                builder: (BuildContext context, bool isShowNewSong) {
                  return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: ShapeDecoration(
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: Theme.of(context).dividerColor))),
                        child: Text(
                          isShowNewSong ? "新歌推荐" : "更多新碟",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}

class NewAlbumGrid extends StatelessWidget {
  const NewAlbumGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List>(
      distinct: true,
      converter: (Store store) => store.state.newAlbumList,
      builder: (BuildContext context, List newAlbum) {
        return SliverPadding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          sliver: CustomSliverGrid(
              childer: newAlbum
                  .map((item) => Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "images/ph.png",
                                  image: item.picUrl,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              item.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Expanded(
                                child: Text(
                              item.artists.join("-"),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.grey),
                            ))
                          ],
                        ),
                      ))
                  .toList()),
        );
      },
      onInit: (Store store) {
        httpRequest
            .get("/album/new", queryParameter: {"limit": 6}).then((respond) {
          List albumList = respond.data["albums"]
              .map((album) => AlbumItem(
                  id: album["id"],
                  picUrl: album["picUrl"],
                  name: album["name"],
                  artists: (album["artists"] as List)
                      .map((item) =>
                          ArtistItem(id: item["id"], name: item["name"]))
                      .toList()))
              .toList();
          store.dispatch(SetAlbumListAction(albumList));
        });
      },
    );
  }
}

class NewSondGrid extends StatelessWidget {
  const NewSondGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List>(
      distinct: true,
      converter: (Store store) => store.state.newSondList,
      builder: (BuildContext context, List newSong) {
        return SliverPadding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          sliver: CustomSliverGrid(
              childer: newSong
                  .map((item) => Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "images/ph.png",
                                  image: item.picUrl,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              item.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Expanded(
                                child: Text(
                              item.artists.join("-"),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.grey),
                            ))
                          ],
                        ),
                      ))
                  .toList()),
        );
      },
      onInit: (Store store) {
        httpRequest
            .get("/top/song", queryParameter: {"type": 0}).then((respond) {
          List songList = respond.data["data"]
              .sublist(0, 6)
              .map((song) => SongItem(
                  id: song["id"],
                  picUrl: song["album"]["picUrl"],
                  name: song["name"],
                  artists: (song["artists"] as List)
                      .map((item) =>
                          SongArtistItem(id: item["id"], name: item["name"]))
                      .toList()))
              .toList();
          store.dispatch(SetNewSondListAction(songList));
        });
      },
    );
  }
}
