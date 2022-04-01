import 'package:flutter/material.dart';
import 'package:flutter_app/utils/handle_count.dart';

class PlayListInfo extends StatelessWidget {
  final String name;
  final String cover;
  final String avatar;
  final String nickname;
  final String description;
  final num playCount;

  PlayListInfo(
      {required this.name,
      required this.cover,
      required this.avatar,
      required this.nickname,
      required this.description,
      required this.playCount});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 140,
            margin: const EdgeInsets.only(right: 16),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: FadeInImage.assetNetwork(
                      placeholder: "images/ph.png", image: cover),
                ),
                Positioned(
                  top: 4.0,
                  right: 4.0,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      Text(
                        handleCount(playCount),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(avatar),
                      ),
                    ),
                    Text(
                      nickname + " →",
                      style: TextStyle(
                          fontSize: 18, color: Colors.white.withOpacity(0.8)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 15),
                    ),
                  ),
                  Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white.withOpacity(0.3),
                  )
                ],
              )
            ],
          )),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
    ));
  }
}
