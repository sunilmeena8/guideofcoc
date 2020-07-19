import 'package:flutter/material.dart';
import 'package:guideofcoc/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COC guide',
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
