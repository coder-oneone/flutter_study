// 设置轮播图
class SetBannersAction {
  List banners;
  SetBannersAction(this.banners);
}

// 推荐歌单
class SetRecommendPlayListAction {
  List recommendPlayList;
  SetRecommendPlayListAction(this.recommendPlayList);
}

// 是否展示新歌
class SetShowNewSondAction {
  bool showNewSond;
  SetShowNewSondAction(this.showNewSond);
}

// 设置新碟
class SetAlbumListAction {
  List albumList;
  SetAlbumListAction(this.albumList);
}

// 设置新歌
class SetNewSondListAction {
  List newSondList;
  SetNewSondListAction(this.newSondList);
}
