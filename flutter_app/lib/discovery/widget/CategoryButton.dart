import 'package:flutter/material.dart';
import 'package:flutter_app/commonWidget/CustomIconButton.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButton(icon: Icons.date_range_sharp, text: "每日推荐"),
            CustomIconButton(icon: Icons.date_range_sharp, text: "歌单"),
            CustomIconButton(icon: Icons.date_range_sharp, text: "排行"),
            CustomIconButton(icon: Icons.date_range_sharp, text: "电台"),
            CustomIconButton(icon: Icons.date_range_sharp, text: "直播"),
          ],
        ),
      ),
    );
  }
}
