import 'package:flutter/material.dart';
import 'package:flutter_app/player/widget/playControl.dart';
import 'package:flutter_app/player/widget/seekBar.dart';
import 'package:flutter_app/player/widget/shareButtons.dart';

import '../commonWidget/CustomBackButton.dart';

class PlayerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(
            color: Colors.white,
          ),
          title: const Text("sss"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
              color: Colors.white,
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Column(children: [
          Expanded(child: Container()),
          ShareButtons(),
          const SizedBox(height: 10,),
          SeekBar(),
          const SizedBox(height: 20,),
          PlayControl()
        ],),
      ),
    );
  }
}
