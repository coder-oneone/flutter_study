import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../player/player.dart';

class PlayerButtonView extends StatelessWidget {
  const PlayerButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: IconButton(onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
            return PlayerView();
          }));
        }, icon: const Icon(Icons.play_circle)),
        color: Colors.white.withOpacity(0),
      ),
    );
  }
}
