import 'package:flutter/material.dart';
import 'package:guideofcoc/utils/fav_utils.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
            List<String> keys = map.data.keys.toList();
            print(keys);
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: keys.map((key) {
                BaseLayoutItem item = new BaseLayoutItem();
                item.url = map.data[key].split(";")[0];
                item.download_url = map.data[key].split(";")[0];
                item.favourite = true;
                return BaseLayoutCard(item, key);
              }).toList(),
            );
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
            new Positioned.fill(
                child: Image.network(
              item.url,
              fit: BoxFit.cover,
            )),
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
                      _launchURL(item.download_url.toString());
                    },
                    child: Icon(Icons.file_download, color: Colors.white)))
          ],
        ));
  }

  _launchURL(String copy_url) async {
    String url = copy_url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
