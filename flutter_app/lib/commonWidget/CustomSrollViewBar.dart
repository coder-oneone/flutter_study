import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSrollContainer extends StatelessWidget {
  Widget child;
  CustomSrollContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: SafeArea(
        child: child,
      ),
    );
  }
}
