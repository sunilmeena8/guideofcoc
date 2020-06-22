import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBaseAttackStrategy extends StatefulWidget {
  @override
  _HomeBaseAttackStrategyState createState() => _HomeBaseAttackStrategyState();
}

class _HomeBaseAttackStrategyState extends State<HomeBaseAttackStrategy>
    with SingleTickerProviderStateMixin {
 
   bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

    String dropdownValue = 'One';


  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton.extended(
      onPressed: null, 
      icon: Icon(Icons.add),
      label: Text("data"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Attack Strategy';
    var hallno = [13, 12, 11, 10, 9, 8, 7, 6];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton:   Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        toggle(),
      ],
    ),
    );
  }
}
