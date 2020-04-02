import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBaseDefence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Defences';
    List<String> defenceName = ['Eagle Artillery','Inferno tower','X-bow','Hidden tesle','Air defence','Scattershot','Wizard tower','Archer tower','Canon','Mortar','Bomb tower','Air sweeper','Tornado trap','Air bomb','Air mine','Skeleton trap','Spring trap','Walls'];

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
                          defenceName.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeBaseDefenceView(defenceName[index])),
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
                                                    defenceName[index],
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

class HomeBaseDefenceView extends StatelessWidget{
  String defencename;
  final children = <Widget>[];
  HomeBaseDefenceView(String defencename){
    this.defencename = defencename;
  }

  @override
  Widget build(BuildContext context){
    final title = defencename;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(defencename)
        )
      );
  }
}

