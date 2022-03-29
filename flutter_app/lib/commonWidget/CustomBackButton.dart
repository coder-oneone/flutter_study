import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color? color;
  final Function? onTap;
  CustomBackButton({this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
          if (onTap != null) {
            onTap!();
          }
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: color,
        ));
  }
}
