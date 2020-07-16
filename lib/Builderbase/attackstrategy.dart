import 'package:flutter/material.dart';
import 'package:guideofcoc/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BuilderBaseAttackStrategy extends StatefulWidget {
  @override
  _BuilderBaseAttackStrategyState createState() =>
      _BuilderBaseAttackStrategyState();
}

class _BuilderBaseAttackStrategyState extends State<BuilderBaseAttackStrategy> {
  List<YoutubePlayerController> _controllers;
  var title = 'Attack Strategy Videos';
  String _bhvalue = appState[dataStrings[2]][0];

  final Firestore db = Firestore.instance;
  YoutubeMetaData _videoMetaData;
  PlayerState _playerState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        title: new Theme(
          child: Row(
            children: <Widget>[
              new DropdownButtonHideUnderline(
                child: new DropdownButton<dynamic>(
                  dropdownColor: Color(0xff363636),
                  value: _bhvalue,
                  items: appState[dataStrings[2]].map(
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
                      _bhvalue = value;
                      _controllers = null;
                      getControllers(_bhvalue);
                      print(_controllers);
                    });
                  },
                ),
              ),
            ],
          ),
          data: new ThemeData.dark(),
        ),
      ),
      body: AttackVideoList(context, _bhvalue),
    );
  }

  @override
  void initState() {
    getControllers(_bhvalue);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    super.initState();
  }

  getControllers(String bh) {
    db
        .collection("videos/builder base/" + bh + "/")
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
              'Please wait...',
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, fontFamily: 'Quicksand'),
            ),
          ],
        ),
      );
    }
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
