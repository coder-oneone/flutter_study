import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/models.dart';
import 'package:redux/redux.dart';

import '../viewmodel/song_item.dart';

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

// 设置是否展示新歌
final showNewSondReducer = combineReducers<bool>(
    [TypedReducer<bool, SetShowNewSondAction>(_showNewSond)]);
bool _showNewSond(bool showNewSong, SetShowNewSondAction action) {
  showNewSong = action.showNewSond;
  return showNewSong;
}

// 设置新碟
final albumListReducer = combineReducers<List>(
    [TypedReducer<List, SetAlbumListAction>(_albumListReducer)]);
List _albumListReducer(List albumList, SetAlbumListAction action) {
  albumList = action.albumList;
  return albumList;
}

// 设置新歌
final newSondListReducer = combineReducers<List>(
    [TypedReducer<List, SetNewSondListAction>(_newSondList)]);
List _newSondList(List newSondList, SetNewSondListAction action) {
  newSondList = action.newSondList;
  return newSondList;
}

// 设置播放列表
final newSondPlayListReducer = combineReducers<PlayListModel>(
    [TypedReducer<PlayListModel, SetPalyListModelAction>(_newSondPlayList)]);
PlayListModel _newSondPlayList(PlayListModel newSondList, SetPalyListModelAction action) {
  newSondList = action.newSondList;
  return newSondList;
}
