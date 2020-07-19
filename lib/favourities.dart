import 'package:flutter/material.dart';
import 'package:guideofcoc/utils/fav_utils.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:guideofcoc/utils/launch_url_utils.dart';
import 'Homevillage/baselayouts.dart';

class Favourities extends StatefulWidget {
  final String villageType;
  Favourities(this.villageType);

  @override
  _FavouritiesState createState() => _FavouritiesState();
}

class _FavouritiesState extends State<Favourities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff000000),
        title: Text("Favourities"),
      ),
      body: FutureBuilder(
          future: FavUtils.getAllFavourities(widget.villageType),
          builder: (context, map) {
            if (map.connectionState == ConnectionState.waiting) {
              return Container(
                padding: EdgeInsets.only(top: 50.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //loader
                    SizedBox(height: 15.0),
                    Text(
                      'Please wait...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Quicksand'),
                    ),
                  ],
                ),
              );
            } else {
              if (map.data.length > 0) {
                List<String> keys = map.data.keys.toList();
                return ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  children: keys.map((key) {
                    BaseLayoutItem item = new BaseLayoutItem();
                    item.url = map.data[key].split(";")[0];
                    item.download_url = map.data[key].split(";")[0];
                    item.favourite = true;
                    return BaseLayoutCard(item, key);
                  }).toList(),
                );
              } else {
                return Container(
                  padding: EdgeInsets.only(top: 50.0),
                  height: MediaQuery.of(context).size.height - 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/not-found.png',
                          width: 40, height: 40.0),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'No favourities',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                            fontFamily: 'Quicksand'),
                      ),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }

  Widget BaseLayoutCard(BaseLayoutItem item, String id) {
    return Container(
        width: 400,
        height: 250,
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
            new Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailScreen(item.url,item.download_url);
                  }));
                },
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: item.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: 210,
                left: 10,
                child: GestureDetector(
                    onTap: item.favourite == false
                        ? () {
                            item.favourite = !item.favourite;
                            FavUtils.addFav(
                                id,
                                item.url + ";" + item.download_url,
                                widget.villageType);
                            setState(() {});
                          }
                        : () {
                            FavUtils.removeFav(id, widget.villageType);
                            setState(() {
                              item.favourite = !item.favourite;
                            });
                          },
                    child: Icon(Icons.favorite,
                        color: item.favourite == false
                            ? Colors.white
                            : Colors.pink[300]))),
            Positioned(
              top: 10,
              left: 350,
              child: GestureDetector(
                onTap: () {
                  Share.share(item.download_url.toString());
                },
                child: Icon(
                  Icons.share,
                  color: Colors.blue[300],
                ),
              ),
            ),
            Positioned(
                top: 210,
                left: 350,
                child: GestureDetector(
                    onTap: () {
                      UrlUtil.launchURL(item.download_url.toString());
                    },
                    child: Icon(Icons.file_download, color: Colors.white)))
          ],
        ));
  }

  
}
