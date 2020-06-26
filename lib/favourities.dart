import 'package:flutter/material.dart';

class Favourities extends StatefulWidget {
  @override
  _FavouritiesState createState() => _FavouritiesState();
}

class _FavouritiesState extends State<Favourities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite"),
      ),
    );
  }
}