class SongItem {
  int id;
  String picUrl;
  String name;
  List<SongArtistItem>? artists;
  SongItem({this.id = 0, this.picUrl = "", this.name = "", this.artists});
}

class SongArtistItem {
  int id;
  String name;
  SongArtistItem({this.id = 0, this.name = ""});
}
