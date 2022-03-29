class AlbumItem {
  int id;
  String picUrl;
  String name;
  List<ArtistItem>? artists;
  AlbumItem({this.id = 0, this.picUrl = "", this.name = "", this.artists});
}

class ArtistItem {
  int id;
  String name;
  ArtistItem({this.id = 0, this.name = ""});
}
