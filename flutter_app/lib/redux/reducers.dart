import 'package:flutter_app/redux/actions.dart';
import 'package:redux/redux.dart';

// 设置轮播图
final bannerReducer =
    combineReducers<List>([TypedReducer<List, SetBannersAction>(_setBanner)]);
List _setBanner(List banners, SetBannersAction action) {
  banners = action.banners;
  return banners;
}

// 设置推荐歌单
final recommendPlayListReducer = combineReducers<List>(
    [TypedReducer<List, SetRecommendPlayListAction>(_recommendPlayList)]);
List _recommendPlayList(
    List recommendPlayList, SetRecommendPlayListAction action) {
  recommendPlayList = action.recommendPlayList;
  return recommendPlayList;
}
