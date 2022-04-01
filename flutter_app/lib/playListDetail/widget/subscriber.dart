import 'package:flutter/material.dart';

import '../../utils/handle_count.dart';
import '../../viewmodel/play_list_detail.dart';

class SubscriberView extends StatelessWidget {
  final List<Subscriber> subscreiberList;
  final num totalSubscriber;

  SubscriberView(
      {required this.subscreiberList, required this.totalSubscriber});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Row(
                children: subscreiberList
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(e.avatarUrl),
                          ),
                        ))
                    .toList(),
              )),
              Text(
                "${handleCount(totalSubscriber)}人收藏",
                style: const TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Icon(Icons.arrow_right))
            ],
          ),
        ),
      ),
    );
  }
}
