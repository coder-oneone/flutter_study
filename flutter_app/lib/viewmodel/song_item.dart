import 'package:flutter_app/viewmodel/album_item.dart';

class SongItem {
  int id;
  int mvId;
  String picUrl;
  String name;
  List<SongArtistItem>? artists;
  SongItem(
      {this.id = 0,
      this.picUrl = "",
      this.name = "",
      this.artists,
      required this.mvId});
}

class SongArtistItem {
  int id;
  String name;
  SongArtistItem({this.id = 0, this.name = ""});
}
