import 'package:flutter/material.dart';
import 'package:flutter_app/utils/handle_count.dart';

class PlayListButtons extends StatelessWidget {
  final int commentCount;
  final int shareCount;
  PlayListButtons({required this.commentCount, required this.shareCount});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Buttons(
                icon: Icons.chat,
                text: handleCount(commentCount),
                onTap: () {}),
            Buttons(
                icon: Icons.share, text: handleCount(shareCount), onTap: () {}),
            Buttons(icon: Icons.download, text: "下载", onTap: () {}),
            Buttons(icon: Icons.select_all, text: "多选", onTap: () {}),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 16),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  Buttons({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style:
                const TextStyle(color: Colors.white, height: 1.5, fontSize: 15),
          )
        ],
      ),
      onTap: () {},
    );
  }
}
