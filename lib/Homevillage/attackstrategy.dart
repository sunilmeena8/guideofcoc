import 'package:flutter/material.dart';
import 'package:guideofcoc/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeBaseAttackStrategy extends StatefulWidget {
  @override
  _HomeBaseAttackStrategyState createState() => _HomeBaseAttackStrategyState();
}

class _HomeBaseAttackStrategyState extends State<HomeBaseAttackStrategy> {
  List<YoutubePlayerController> _controllers;
  var title = 'Attack Strategy Videos';
  String _thvalue = thList[0];

  final Firestore db = Firestore.instance;
  YoutubeMetaData _videoMetaData;
  PlayerState _playerState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff000000),
        title: new Theme(
          child: Row(
            children: <Widget>[
              new DropdownButtonHideUnderline(
                child: new DropdownButton<String>(
                  dropdownColor: Colors.blue[300],
                  value: _thvalue,
                  items: thList.map(
                    (item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String value) {
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
      body: AttackVideoList(context, _thvalue),
    );
  }

  @override
  void initState() {
    getControllers(_thvalue);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    super.initState();
  }

  Widget AttackVideoList(context, String _thvalue) {
    if (_controllers != null) {
      if (_controllers.length > 0) {
        return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            itemCount: _controllers.length,
            itemBuilder: (BuildContext context, int index) {
              // print(_controllers);
              return AttackVideoCard(_controllers[index]);
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
                'No Activities Yet',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
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
              'Please Wait',
              style: TextStyle(
                  color: Colors.black, fontSize: 14.0, fontFamily: 'Quicksand'),
            ),
          ],
        ),
      );
    }
  }

  getControllers(String th) {
    db
        .collection("videos/home village/" + th + "/")
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) async {
        var urls = result.data['urls'];
        
        var ids = [];
        if (urls.length > 0) {
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

  bool _isPlayerReady = false;

  Widget AttackVideoCard(YoutubePlayerController _controller) {
    // while(_isPlayerReady==false);
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
            FullScreenButton(),
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
            _isPlayerReady = true;

            setState(() {
              _videoMetaData = _controller.metadata;
            });
          },
        ),
        builder: (context, player) => Column(
          children: [player],
        ),
      ),
    );
  }
}
