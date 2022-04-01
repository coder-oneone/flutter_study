import 'package:flutter_app/viewmodel/album_item.dart';
import 'package:flutter_app/viewmodel/song_item.dart';

class PlayListDetailModel {
  int id;
  int commentCount;
  int shareCount;
  int subscribedCount;
  num playCount;
  String name;
  String description;
  String coverImgUrl;
  Creator creator;
  List<SongItem> songList;
  List<Subscriber> subscriberList;
  PlayListDetailModel(
      {required this.id,
      required this.commentCount,
      required this.shareCount,
      required this.subscribedCount,
      required this.name,
      required this.description,
      required this.coverImgUrl,
      required this.playCount,
      required this.creator,
      required this.songList,
      required this.subscriberList});
  factory PlayListDetailModel.fromJson(Map<String, dynamic> json) {
    var songs = json["tracks"] as List;
    var subscribers = json["subscribers"] as List;
    return PlayListDetailModel(
        id: json["id"],
        commentCount: json["commentCount"],
        shareCount: json["shareCount"],
        subscribedCount: json["subscribedCount"],
        name: json["name"],
        description: json["description"],
        coverImgUrl: json["coverImgUrl"],
        playCount: json["playCount"],
        creator: Creator.fromJson(json["creator"]),
        songList: songs
            .map((item) => SongItem(
                mvId: item["mv"],
                id: item["id"],
                name: item["name"],
                picUrl: item["al"]["picUrl"],
                artists: (item["ar"] as List)
                    .map((it) => SongArtistItem(id: it["id"], name: it["name"]))
                    .toList()))
            .toList(),
        subscriberList: subscribers
            .map((su) =>
                Subscriber(id: su["userId"], avatarUrl: su["avatarUrl"]))
            .toList());
  }
}

class Creator {
  int id;
  String nickName;
  String avatarUrl;

  Creator({
    this.id = 0,
    this.nickName = "",
    this.avatarUrl = "",
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
        id: json["userId"],
        nickName: json["nickname"],
        avatarUrl: json["avatarUrl"]);
  }
}

class Subscriber {
  int id;
  String avatarUrl;
  Subscriber({this.id = 0, this.avatarUrl = ""});
}
