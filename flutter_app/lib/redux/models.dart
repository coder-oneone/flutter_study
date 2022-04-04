import '../viewmodel/song_item.dart';

class PlayListModel {
  int id;
  List songList;
  PlayListModel({required this.id, required this.songList});

  @override
  String toString() {
    return 'PlayListModel{id: $id, songList: $songList}';
  }
}
