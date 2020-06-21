import 'package:flutter/material.dart';

class HomeBaseTroops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Troops';
    List<String> troopName = [
      'Barbarian',
      'Archer',
      'Goblin',
      'Wall breaker',
      'Giant',
      'Wizard',
      'Healer',
      'Balloon',
      'Dragon',
      'Baby dragon',
      'Pekka',
      'Miner',
      'Electro dragon',
      'Yeti',
      'Minion',
      'Hog rider',
      'Valkyrie',
      'Golem',
      'Witch',
      'Lava hound',
      'Bowler',
      'Ice golem',
    ];

    var troopsImages = [
    'images/home base/troops/barbarian.jpg',
    'images/home base/troops/archer.jpg',
    'images/home base/troops/goblin.jpg',
    'images/home base/troops/wallbreaker.jpg',
    'images/home base/troops/giant.jpg',
    'images/home base/troops/wizard.jpg',
    'images/home base/troops/healer.jpg',
    'images/home base/troops/balloon.jpg',
    'images/home base/troops/dragon.jpg',
    'images/home base/troops/babydragon.jpg',
    'images/home base/troops/pekka.jpg',
    'images/home base/troops/miner.jpg',
    'images/home base/troops/electrodragon.jpg',
    'images/home base/troops/yeti.jpg',
    'images/home base/troops/minion.jpg',
    'images/home base/troops/hogrider.jpg',
    'images/home base/troops/valkyrie.jpg',
    'images/home base/troops/golem.jpg',
    'images/home base/troops/witch.jpg',
    'images/home base/troops/lavahound.jpg',
    'images/home base/troops/bowler.jpg',
    'images/home base/troops/icegolem.jpg',
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
              troopName.length,
              (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeBaseTroopsView(troopName[index])),
                      );
                    },
                    child: Container(
                        // margin: EdgeInsets.all(1.0),
                        child: Stack(
                      children: <Widget>[
                        Container(
                          child: Image(
                              image: AssetImage(
                                  troopsImages[index])),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              width: 300,
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: Text(troopName[index],
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

class HomeBaseTroopsView extends StatelessWidget {
  String name;
  final children = <Widget>[];
  HomeBaseTroopsView(String name) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    final title = name;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: Text(name)));
  }
}
