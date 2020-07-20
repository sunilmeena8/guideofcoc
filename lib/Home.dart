import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guideofcoc/Builderbase/attackstrategy.dart';
import 'package:guideofcoc/Builderbase/baselayouts.dart';
import 'package:guideofcoc/Homevillage/attackstrategy.dart';
import 'package:guideofcoc/Homevillage/baselayouts.dart';
import 'package:guideofcoc/latestupdates.dart';
import 'package:guideofcoc/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CarouselSlider topSlider;
  var popupChoices = [
    "Share",
    "Rate Us",
    "Contact Us",
  ];
  var choiceIcons = {
    "Share": Icons.share,
    "Rate Us": Icons.star_border,
    "Contact Us": Icons.mail_outline,
  };
  var popupUrls = [
    "Hey Clashers i have an amzing app for you, Pls Download..  https://play.google.com/store/apps/details?id=com.clashofclans.guideofcoc",
    "https://play.google.com/store/apps/details?id=com.clashofclans.guideofcoc",
  ];
  final Firestore db = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  void handleClick(String value) {
    switch (value) {
      case 'Share':
        Share.share(popupUrls[popupChoices.indexOf(value)]);
        break;
      case "Contact Us":
        mail();
        break;
      case "Rate Us":
        launch_url(popupUrls[popupChoices.indexOf(value)]);
        break;
    }
  }

  getSlider() {
    return CarouselSlider(
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: true,
      items: appState[dataStrings[0]].map(
        (urls) {
          var imgUrl, pageUrl;
          imgUrl = urls.split(";")[0];
          pageUrl = urls.split(";")[1];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LatestUpdates(pageUrl),
                  ));
            },
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  imgUrl,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xff272727),
        title: Text(
          'GUIDE OF COC',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              color: Colors.blue[200],
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5),
          textAlign: TextAlign.left,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Color(0xff272727),
            icon: Icon(Icons.more_vert, color: Colors.blue[200]),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return popupChoices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Icon(choiceIcons[choice], color: Colors.blue[200]),
                      Text("  " + choice,
                          style: TextStyle(color: Colors.blue[200])),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          getSlider(),
          Container(
            margin: EdgeInsets.only(bottom: 5, left: 10),
            child: Text(
              'Home Village',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                color: Colors.blue[200],
                fontWeight: FontWeight.w700,
                height: 2.4187634785970054,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                choiceCard(context, 'Base Layouts', HomeBaseBaseLayouts(),
                    "images/home base/baselayouts.jpg"),
                choiceCard(context, 'Attack Videos', HomeBaseAttackStrategy(),
                    "images/home base/thvideos.jpg"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5, left: 10),
            child: Text(
              'Builder Base',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                color: Colors.blue[200],
                fontWeight: FontWeight.w700,
                height: 2.4187634785970054,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                choiceCard(context, 'Base Layouts', BuilderBaseBaseLayouts(),
                    "images/builder base/bhlayouts.jpg"),
                choiceCard(
                    context,
                    'Attack Videos',
                    BuilderBaseAttackStrategy(),
                    "images/builder base/bhvideos.jpg"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget choiceCard(
      context, String text, Widget widget, String backgroundImage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.44,
            height: MediaQuery.of(context).size.height * 0.214,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgroundImage), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xff3b3b3b),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x1a7364f8),
                  offset: Offset(-2.723942995071411, 5.346039295196533),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.44,
              height: MediaQuery.of(context).size.height * 0.048,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xd0626262),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  color: Colors.blue[100],
                  letterSpacing: 0.24,
                  fontWeight: FontWeight.w600,
                  height: 0.00235 * MediaQuery.of(context).size.height,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  mail() async {
    const url = 'mailto:guideofcoc@gmail.com?subject= Help and Support';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launch_url(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
