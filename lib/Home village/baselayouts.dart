import 'package:flutter/material.dart'; 
import 'package:url_launcher/url_launcher.dart';

class HomeBaseBaseLayouts extends StatelessWidget {
  var townHalls = [
    'images/home base/th13.jpg',
    'images/home base/th12.jpg',
    'images/home base/th11.jpg',
    'images/home base/th10.jpg',
    'images/home base/th9.jpg',
    'images/home base/th8.jpg',
    'images/home base/th7.jpg',
    'images/home base/th6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final title = 'Base Layouts';
    var hallno = [13,12,11,10,9,8,7,6];
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
                                        builder: (context) => HomeBaseBaseLayoutsView(hallno[index])),
                                  );
                                },
                                child: Container(
                                    // margin: EdgeInsets.all(1.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Image(
                                            image: AssetImage(
                                                townHalls[index])),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: 300,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: Center(
                                                child: Text(
                                                    "Town hall ${hallno[index]}",
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

class HomeBaseBaseLayoutsView extends StatelessWidget{
  int townHall;
  final children = <Widget>[];
  HomeBaseBaseLayoutsView(int townHall){
    this.townHall = townHall;
  }

  @override
  Widget build(BuildContext context){
    final title = "Base Layouts";
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

