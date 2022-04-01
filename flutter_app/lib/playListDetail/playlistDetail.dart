import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/commonWidget/CustomBackButton.dart';
import 'package:flutter_app/commonWidget/CustomSrollViewBar.dart';
import 'package:flutter_app/httpRequest.dart';
import 'package:flutter_app/playListDetail/widget/playList.dart';
import 'package:flutter_app/playListDetail/widget/playListButtons.dart';
import 'package:flutter_app/playListDetail/widget/playListInfo.dart';
import 'package:flutter_app/playListDetail/widget/subscriber.dart';
import 'package:flutter_app/viewmodel/play_list_detail.dart';

class PlayListDetailView extends StatefulWidget {
  final int id;
  PlayListDetailView({required this.id});

  @override
  State<PlayListDetailView> createState() => _PlayListDetailViewState();
}

class _PlayListDetailViewState extends State<PlayListDetailView> {
  PlayListDetailModel? _playListDetailModel;
  @override
  void initState() {
    httpRequest.get("/playlist/detail",
        queryParameter: {"id": widget.id, "s": 5}).then((response) {
      setState(() {
        _playListDetailModel =
            PlayListDetailModel.fromJson(response.data["playlist"]);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_playListDetailModel != null) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: NetworkImage(_playListDetailModel!.coverImgUrl),
                fit: BoxFit.cover)),
        child: ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Scaffold(
                appBar: AppBar(
                    leading: CustomBackButton(
                      color: Colors.white,
                    ),
                    title: const Text(
                      "歌单",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.transparent,
                    centerTitle: true),
                backgroundColor: Colors.transparent,
                body: CustomSrollContainer(
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        PlayListInfo(
                            name: _playListDetailModel!.name,
                            cover: _playListDetailModel!.coverImgUrl,
                            avatar: _playListDetailModel!.creator.avatarUrl,
                            nickname: _playListDetailModel!.creator.nickName,
                            description: _playListDetailModel!.description,
                            playCount: _playListDetailModel!.playCount),
                        PlayListButtons(
                            commentCount: _playListDetailModel!.commentCount,
                            shareCount: _playListDetailModel!.shareCount)
                      ];
                    },
                    body: Container(
                      color: Colors.white,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              PlayList(
                                songs: _playListDetailModel!.songList,
                                subscribedCount:
                                    _playListDetailModel!.subscribedCount,
                              ),
                              SubscriberView(
                                  subscreiberList:
                                      _playListDetailModel!.subscriberList,
                                  totalSubscriber:
                                      _playListDetailModel!.subscribedCount),
                            ],
                          )),
                    ),
                  ),
                ),
              )),
        ),
      );
    } else {
      return Container();
    }
  }
}
