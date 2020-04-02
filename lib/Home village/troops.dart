import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBaseTroops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Troops';
    List<String> troopName = ['Barbarian','Archer','Goblin','Wall breaker','Giant','Wizard','Healer','Balloon','Dragon','Baby dragon','Pekka','Miner','Electro dragon','Yeti','Minion','Hog rider','Valkrie','Golem','Witch','Lava hound','Bowler'];

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
                          troopName.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeBaseTroopsView(troopName[index])),
                                  );
                                },
                                child: Container(
                                    // margin: EdgeInsets.all(1.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Image.network(
                                            'https://houseofclashers.com/r/clash-of-clans/images/resize/2020-03-super-troops.547x300q50.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: 300,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: Center(
                                                child: Text(
                                                    troopName[index],
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

class HomeBaseTroopsView extends StatelessWidget{
  String name;
  final children = <Widget>[];
  HomeBaseTroopsView(String name){
    this.name = name;
  }

  @override
  Widget build(BuildContext context){
    final title = name;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(name)
        )
      );
  }
}

