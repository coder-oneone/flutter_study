import 'package:flutter_app/redux/reducers.dart';

class AppState {
  List banners; //轮播图
  List recommendPlayList; // 推荐歌单
  List newAlbumList; // 新碟
  List newSondList; // 新歌
  bool isShowNewSong; // 是否显示新歌
  AppState(
      {required this.banners,
      required this.recommendPlayList,
      required this.isShowNewSong,
      required this.newAlbumList,
      required this.newSondList});
}

AppState appReducer(AppState state, action) {
  return AppState(
      banners: bannerReducer(state.banners, action),
      recommendPlayList:
          recommendPlayListReducer(state.recommendPlayList, action),
      isShowNewSong: showNewSondReducer(state.isShowNewSong, action),
      newAlbumList: albumListReducer(state.newAlbumList, action),
      newSondList: newSondListReducer(state.newSondList, action));
}
