import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  final bool noMore;
  LoadMore({this.noMore = false});
  
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.center,
        child: noMore
            ? const Text("已加载全部")
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 7.0),
                    child: CupertinoActivityIndicator(
                      radius: 7.0,
                    ),
                  ),
                  Text("正在加载...")
                ],
              ),
      ),
    );
  }
}
