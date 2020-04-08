import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBaseDefence extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Defences';
    List<String> defenceName = [
      'Eagle Artillery',
      'Inferno tower',
      'X-bow',
      'Hidden tesle',
      'Air defence',
      'Scattershot',
      'Wizard tower',
      'Archer tower',
      'Canon',
      'Mortar',
      'Bomb tower',
      'Air sweeper',
      'Tornado trap',
      'Air bomb',
      'Air mine',
      'Skeleton trap',
      'Spring trap',
      'Walls'
    ];
      var defenceImg = [
    'images/home base/defence/eagleartillery.jpg',
    'images/home base/defence/inferno.jpg',
    'images/home base/defence/xbow.jpg',
    'images/home base/defence/hiddentesla.jpg',
    'images/home base/defence/airdefence.jpg',
    'images/home base/defence/scattershot.jpg',
    'images/home base/defence/wizardtower.jpg',
    'images/home base/defence/archertower.jpg',
    'images/home base/defence/canon.jpg',
    'images/home base/defence/mortar.jpg',
    'images/home base/defence/bombtower.jpg',
    'images/home base/defence/airsweeper.jpg',
    'images/home base/defence/tornadotrap.jpg',
    'images/home base/defence/airbomb.jpg',
    'images/home base/defence/airmine.jpg',
    'images/home base/defence/skeletontrap.jpg',
    'images/home base/defence/springtrap.jpg',
    'images/home base/defence/wall.jpg',
  ];


    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: new List.generate(
              defenceName.length,
              (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeBaseDefenceView(defenceName[index])),
                      );
                    },
                    child: Container(
                        // margin: EdgeInsets.all(1.0),
                        child: Stack(
                      children: <Widget>[
                        Container(
                            child: Image(image: AssetImage(defenceImg[index]))),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              width: 300,
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: Text(defenceName[index],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)),
                              ),
                            )),
                      ],
                    )),
                  )),
        ),
      ),
    );
  }
}

class HomeBaseDefenceView extends StatelessWidget {
  String defencename;
  final children = <Widget>[];
  HomeBaseDefenceView(String defencename) {
    this.defencename = defencename;
  }

  @override
  Widget build(BuildContext context) {
    final title = defencename;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: Text(defencename)));
  }
}
