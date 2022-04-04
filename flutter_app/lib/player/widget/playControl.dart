import 'package:flutter/material.dart';

class PlayControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.loop),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.preview),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            iconSize: 60,
            icon: const Icon(Icons.play_circle),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.next_plan),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.featured_play_list),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
