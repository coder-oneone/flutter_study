import 'package:flutter_app/redux/reducers.dart';

class AppState {
  List banners; //轮播图
  List recommendPlayList; // 推荐歌单
  AppState({required this.banners, required this.recommendPlayList});
}

AppState appReducer(AppState state, action) {
  return AppState(
      banners: bannerReducer(state.banners, action),
      recommendPlayList:
          recommendPlayListReducer(state.recommendPlayList, action));
}
