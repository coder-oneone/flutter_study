import 'package:flutter/material.dart';

class CustomSliverGrid extends StatelessWidget {
  final List<Widget> childer;
  CustomSliverGrid({required this.childer});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      childAspectRatio: 0.75,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: childer,
    );
  }
}
