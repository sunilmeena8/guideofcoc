import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'Builder base/attackstrategy.dart';
import 'Builder base/baselayouts.dart';
import 'Builder base/defence.dart';
import 'Builder base/heroes.dart';
import 'Builder base/otherbuildings.dart';
import 'Builder base/troops.dart';
import 'Home village/attackstrategy.dart';
import 'Home village/baselayouts.dart';
import 'Home village/defence.dart';
import 'Home village/heroes.dart';
import 'Home village/otherbuildings.dart';
import 'Home village/spells.dart';
import 'Home village/troops.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> imgList = [
    'https://houseofclashers.com/r/clash-of-clans/images/resize/2020-03-super-troops.547x300q50.jpg',
    'https://houseofclashers.com/r/clash-of-clans/images/resize/2020-03-super-giant-00.533x300q50.jpg',
    'https://houseofclashers.com/r/clash-of-clans/images/resize/2020-03-sneaky-goblin-01.533x300q50.jpg',
    'https://houseofclashers.com/r/clash-of-clans/images/resize/super-barbarian-02.533x300q50.jpg',
    'https://houseofclashers.com/r/clash-of-clans/images/resize/sneak_peeks.549x300q50.jpg',
    'https://houseofclashers.com/r/clash-of-clans/images/resize/clangames.574x300q50.jpg',
    'https://houseofclashers.com/r/clash-of-clans/images/resize/2020-03-sneaky-goblin-01.533x300q50.jpg',
  ];
  final List<String> homevillageAttrs = [
    'Base layouts',
    'Attack strategy',
    'Heroes',
    'Troops',
    'Spells',
    'Defence',
    'Other Buildings',
  ];
  final List<String> buildervillageAttrs = [
    'Base layouts',
    'Attack strategy',
    'Battle Machine',
    'Defence',
    'Troops',
    'Other Buildings',
  ];

  
  var homeVillageFunctions = [HomeBaseBaseLayouts(),HomeBaseAttackStrategy(),HomeBaseHeroes(),HomeBaseTroops(),HomeBaseSpells(),HomeBaseDefence(),HomeBaseOtherBuildings()];
  var builderBaseFunctions = [BuilderBaseBaseLayouts(),BuilderBaseAttackStrategy(),BuilderBaseHeroes(),BuilderBaseDefence(),BuilderBaseTroops(),BuilderBaseOtherBuildings()];


  @override
  Widget build(BuildContext context) {
    final CarouselSlider updates = CarouselSlider(
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: true,
      items: imgList.map(
        (url) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
          );
        },
      ).toList(),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: nDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Guide of COC",
          style:
              TextStyle(fontWeight:  FontWeight.w800, color: Colors.deepPurple),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              color: Colors.deepPurpleAccent,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          updates,
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Home Village",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.deepPurple),
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: new List.generate(
                        homevillageAttrs.length,
                        (index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => homeVillageFunctions[index]),
                                );
                              },
                              child: Container(
                                  margin: EdgeInsets.all(4.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        child: Image.network(
                                          imgList[index],
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
                                                  homevillageAttrs[index],
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
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Builder Base",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.deepPurple),
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: new List.generate(
                        buildervillageAttrs.length,
                        (index) => GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => builderBaseFunctions[index]));
                          },
                          child: Container(
                              margin: EdgeInsets.all(4.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    child: Image.network(
                                      imgList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: Container(
                                        width: 300,
                                        color: Colors.black.withOpacity(0.5),
                                        child: Center(
                                          child: Text(buildervillageAttrs[index],
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nDrawer() {
    var textStyle = TextStyle(
        fontSize: 35, fontWeight: FontWeight.w800, color: Colors.deepPurple);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Guide of COC', style: textStyle),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://houseofclashers.com/r/clash-of-clans/images/resize/2020-03-sneaky-goblin-01.533x300q50.jpg"))),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.star_border,
                color: Colors.redAccent,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text("Rate Us",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.share,
                color: Colors.purple,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text("Share",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.book,
                color: Colors.brown,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text("Privacy & Policy",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.mail,
                color: Colors.pink,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text("Contact Us",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}

