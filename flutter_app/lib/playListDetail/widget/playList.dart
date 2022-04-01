import 'package:flutter/material.dart';
import 'package:flutter_app/utils/handle_count.dart';
import 'package:flutter_app/viewmodel/song_item.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class PlayList extends StatelessWidget {
  final List<SongItem> songs;
  final int subscribedCount;
  PlayList({required this.songs, required this.subscribedCount});

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.play_circle),
                  ),
                  RichText(
                      text: TextSpan(
                          text: "播放全部",
                          style: TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: "（共${songs.length}首）",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12))
                      ]))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Text(
                  "+ 收藏(${handleCount(subscribedCount)})",
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    shadows: [
                      BoxShadow(
                        color: Colors.redAccent,
                      ),
                    ],
                    gradient: LinearGradient(
                        colors: [Colors.redAccent, Colors.yellow],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
              ),
            )
          ],
        ),
      ),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        SongItem item = songs[index];
        return GestureDetector(
          onTap: () {},
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  (index + 1).toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        item.artists!.map((e) => e.name).toList().join('/') +
                            '-${item.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                )),
                Row(
                  children: [
                    item.mvId > 0
                        ? const Icon(
                            Icons.play_arrow,
                            color: Colors.grey,
                          )
                        : Container(),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }, childCount: songs.length)),
    );
  }
}
