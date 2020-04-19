import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BuilderBaseBaseLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Base Layouts';
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
                                        builder: (context) => BaseLayoutsView(hallno[index])),
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

class BaseLayoutsView extends StatelessWidget{
  int townHall;
  final children = <Widget>[];
  BaseLayoutsView(int townHall){
    this.townHall = townHall;
  }

  @override
  Widget build(BuildContext context){
    final title = "Base Layouts";
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text('Town Hall '+townHall.toString())
        )
      );
  }
}

