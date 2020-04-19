import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BuilderBaseAttackStrategy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Attack Strategy';
    var hallno = [9,8,7,6,5];
    var builderHalls = [
    'images/builder base/builderhall/bh9.jpg',
    'images/builder base/builderhall/bh8.jpg',
    'images/builder base/builderhall/bh7.jpg',
    'images/builder base/builderhall/bh6.jpg',
    'images/builder base/builderhall/bh5.jpg',
  ];


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
                          hallno.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AttackStrategyView(hallno[index])),
                                  );
                                },
                                child: Container(
                                    // margin: EdgeInsets.all(1.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Image(image: AssetImage(builderHalls[index]))
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: 300,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: Center(
                                                child: Text(
                                                    "Builder hall ${hallno[index]}",
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

class AttackStrategyView extends StatelessWidget{
  int builderHall;
  final children = <Widget>[];
  AttackStrategyView(int builderHall){
    this.builderHall = builderHall;
  }

  @override
  Widget build(BuildContext context){
    final title = "Attack Strategy";
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 1,
          // Generate 100 widgets that display their index in the List.
          children: new List.generate(
                        8,
                        (index) => GestureDetector(
                              onTap: () => launch('youtube.com/watch?v=ixkoVwKQaJg&list=RDEMosgKaT7FZkH72hYMznTFHA&index=24'),
                              
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
                                                  "Town hall $index",
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
      );
  }
}

