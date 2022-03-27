import 'package:flutter/material.dart';
import 'package:flutter_app/utils/handle_count.dart';

class CustomPlayListItem extends StatelessWidget {
  final String name;
  final String picUrl;
  final num palyCount;
  final int id;
  // ignore: use_key_in_widget_constructors
  const CustomPlayListItem(
      {required this.name,
      required this.picUrl,
      required this.palyCount,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: "images/ph.png",
                      image: picUrl,
                      fit: BoxFit.cover,
                    )),
                Positioned(
                  top: 2.0,
                  right: 4.0,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.play_arrow,
                        size: 14.0,
                        color: Colors.white,
                      ),
                      Text(
                        handleCount(palyCount),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12.0),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 12.0),
            ))
          ],
        ),
      ),
    );
  }
}
