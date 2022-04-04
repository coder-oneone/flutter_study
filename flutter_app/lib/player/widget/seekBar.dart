import 'package:flutter/material.dart';

class SeekBar extends StatelessWidget {
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "00:00",
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
          Expanded(
              child: Slider(
            value: _progress,
            onChanged: (_) {},
            activeColor: Colors.white,
            inactiveColor: Colors.grey[50],
          )),
          Text(
            "00:00",
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
