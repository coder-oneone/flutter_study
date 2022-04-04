import 'package:flutter_app/redux/models.dart';
import 'package:flutter_app/redux/reducers.dart';

class AppState {
  List banners; //轮播图
  List recommendPlayList; // 推荐歌单
  List newAlbumList; // 新碟
  List newSondList; // 新歌
  bool isShowNewSong; // 是否显示新歌
  PlayListModel playListModel; // 播放列表
  AppState(
      {required this.banners,
      required this.recommendPlayList,
      required this.isShowNewSong,
      required this.newAlbumList,
      required this.newSondList,
      required this.playListModel});
}

AppState appReducer(AppState state, action) {
  return AppState(
      banners: bannerReducer(state.banners, action),
      recommendPlayList:
          recommendPlayListReducer(state.recommendPlayList, action),
      isShowNewSong: showNewSondReducer(state.isShowNewSong, action),
      newAlbumList: albumListReducer(state.newAlbumList, action),
      newSondList: newSondListReducer(state.newSondList, action),
      playListModel: newSondPlayListReducer(state.playListModel, action));
}
