import 'package:flutter/material.dart';
import 'package:flutter_app/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        primaryTextTheme: const TextTheme(
            titleSmall: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                height: 1.5)),
        primaryIconTheme: const IconThemeData(color: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
            iconTheme: IconThemeData(color: Colors.black)),
        tabBarTheme: const TabBarTheme(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black),
        // disabledColor: const Color(0x00f3f3f3),
        // indicatorColor: Colors.white,
        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
      ),
      home: Home(),
    );
  }
}
