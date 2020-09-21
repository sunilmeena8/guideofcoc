import 'package:flutter/material.dart';
import 'package:guideofcoc/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class HomeBaseAttackStrategy extends StatefulWidget {
  @override
  _HomeBaseAttackStrategyState createState() => _HomeBaseAttackStrategyState();
}

class _HomeBaseAttackStrategyState extends State<HomeBaseAttackStrategy> {
  List<YoutubePlayerController> _controllers;

  String _thvalue = appState[dataStrings[1]][0];

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff000000),
        title: new Theme(
          child: Row(
            children: <Widget>[
              new DropdownButtonHideUnderline(
                child: new DropdownButton<dynamic>(
                  dropdownColor: Color(0xff363636),
                  value: _thvalue,
                  items: appState[dataStrings[1]].map(
                    (item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              color: Colors.blue[200],
                              fontWeight: FontWeight.w500,
                            )),
                      );
                    },
                  ).toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      _thvalue = value;
                      _controllers = null;
                      getControllers(_thvalue);
                    });
                  },
                ),
              ),
            ],
          ),
          data: new ThemeData.dark(),
        ),
      ),
      body: attackVideoList(context, _thvalue),
    );
  }

  @override
  void initState() {
    getControllers(_thvalue);
    super.initState();
  }

  Widget attackVideoList(context, String _thvalue) {
    if (_controllers != null) {
      if (_controllers.length > 0) {
        return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            itemCount: _controllers.length,
            itemBuilder: (BuildContext context, int index) {
              return attackVideoCard(_controllers[index]);
            });
      } else {
        return Container(
          padding: EdgeInsets.only(top: 50.0),
          height: MediaQuery.of(context).size.height - 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/not-found.png', width: 40, height: 40.0),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'No videos found',
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
    } else {
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
              loadingText,
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, fontFamily: 'Quicksand'),
            ),
          ],
        ),
      );
    }
  }

  getControllers(String th) {
    db
        .collection("homevillage/attackvideos/" + th + "/")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        var urls = result.data()['urls'];

        var ids = [];
        if (urls != null && urls.length > 0) {
          for (int i = 0; i < urls.length; i++) {
            ids.add(YoutubePlayer.convertUrlToId(urls[i]));
          }
        }

        if (ids.length == 0) {
          _controllers = [];
        } else {
          _controllers = ids
              .map<YoutubePlayerController>(
                (videoId) => YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: const YoutubePlayerFlags(
                    autoPlay: false,
                  ),
                ),
              )
              .toList();
        }
        setState(() {});
      });
    });
  }

  Widget attackVideoCard(YoutubePlayerController _controller) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amberAccent,
          bottomActions: <Widget>[
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            PlaybackSpeedButton(),
            IconButton(
              icon: Icon(
                _controller.value.isFullScreen
                    ? Icons.fullscreen_exit
                    : Icons.fullscreen,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                _controller.pause();
                YoutubePlayerController controller = YoutubePlayerController(
                  initialVideoId: _controller.initialVideoId,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                  ),
                );

                _controller.toggleFullScreenMode();
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FullScreen(controller);
                })).then((value) {
                  _controller.toggleFullScreenMode();
                });
              },
            ),
          ],
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
          onReady: () {
            setState(() {});
          },
        ),
        builder: (context, player) => Column(
          children: [player],
        ),
      ),
    );
  }
}

class FullScreen extends StatelessWidget {
  final YoutubePlayerController _controller;

  FullScreen(this._controller);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff121212),
        body: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amberAccent,
          bottomActions: <Widget>[
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            PlaybackSpeedButton(),
            IconButton(
              icon: Icon(
                Icons.fullscreen_exit,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ));
  }
}
