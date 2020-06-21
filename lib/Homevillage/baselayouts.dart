import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
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
                              
                              child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-0.4, -365.4),
                  child: Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(20.4, 386.4),
                        child:
                            // Adobe XD layer: '45' (shape)
                            Container(
                          width: 381.0,
                          height: 203.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: const NetworkImage("https://houseofclashers.com/r/clash-of-clans/images/resize/2020-03-sneaky-goblin-01.533x300q50.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(34.0, 191.81),
                  child:
                      // Adobe XD layer: '17' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, 0.0),
                        child: Stack(
                          children: <Widget>[
                            SvgPicture.string(
                              _svg_rc4rdb,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(356.0, 191.81),
                  child:
                      // Adobe XD layer: '17' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, 0.0),
                        child: Stack(
                          children: <Widget>[
                            SvgPicture.string(
                              _svg_rc4rdb,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(356.0, 35.81),
                  child:
                      // Adobe XD layer: '17' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, 0.0),
                        child: Stack(
                          children: <Widget>[
                            SvgPicture.string(
                              _svg_rc4rdb,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          
                            )),
        ),
      );
  }
}



const String _svg_rc4rdb =
    '<svg viewBox="0.0 0.0 21.6 18.8" ><path transform="translate(-24.02, -30.44)" d="M 35.96522903442383 32.0993766784668 L 34.80559539794922 33.25901794433594 L 33.64595413208008 32.0993766784668 C 31.43455123901367 29.88798141479492 27.87472915649414 29.88798141479492 25.66332626342773 32.0993766784668 L 25.66332626342773 32.0993766784668 C 23.4788875579834 34.3107795715332 23.4788875579834 37.8705940246582 25.66332626342773 40.08199691772461 L 34.80559539794922 49.1972770690918 L 43.94785690307617 40.05501937866211 C 46.15925979614258 37.84362411499023 46.15925979614258 34.28380966186523 43.94785690307617 32.07241058349609 L 43.94785690307617 32.07241058349609 C 41.73645401000977 29.88797950744629 38.17663192749023 29.88797950744629 35.96522903442383 32.0993766784668 Z" fill="#7a8fa6" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
