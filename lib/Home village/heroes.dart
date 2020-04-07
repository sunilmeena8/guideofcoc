import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBaseHeroes extends StatelessWidget {
  var heroes = [
    'images/home base/heroes/barbarian_king.jpg',
    'images/home base/heroes/archer_queen.jpg',
    'images/home base/heroes/grand_warden.jpg',
    'images/home base/heroes/royal_champion.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final title = 'Heros';
    List<String> heroesName = ['Barbarian King','Archer Queen','Grand Wardon','Royal champion'];

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body:
          
         Center(
           
           child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: new List.generate(
                          heroesName.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeBaseHeroesView(heroesName[index])),
                                  );
                                },
                                child: Container(
                                    // margin: EdgeInsets.all(1.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Image(image: AssetImage(heroes[index])),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: 300,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: Center(
                                                child: Text(
                                                    heroesName[index],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
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

class HomeBaseHeroesView extends StatelessWidget{
  String heroname;
  final children = <Widget>[];
  HomeBaseHeroesView(String heroname){
    this.heroname = heroname;
  }

  @override
  Widget build(BuildContext context){
    final title = heroname;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(heroname)
        )
      );
  }
}

