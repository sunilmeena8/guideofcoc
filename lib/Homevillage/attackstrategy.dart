import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class HomeBaseAttackStrategy extends StatefulWidget {
  @override
  _HomeBaseAttackStrategyState createState() => _HomeBaseAttackStrategyState();
}

class _HomeBaseAttackStrategyState extends State<HomeBaseAttackStrategy> {
  YoutubePlayerController _controller;
  var title = 'Attack Strategy Videos';
  String _thvalue = "Town Hall 13";
  var nameList = [
    "Town Hall 13",
    "Town Hall 12",
    "Town Hall 11",
    "Town Hall 10",
    "Town Hall 9",
    "Town Hall 8",
    "Town Hall 7",
  ];
  final Firestore db = Firestore.instance;
  YoutubeMetaData _videoMetaData;
  PlayerState _playerState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Theme(
          child: Row(
            children: <Widget>[
              new DropdownButtonHideUnderline(
                child: new DropdownButton<String>(
                  dropdownColor: Colors.blue[300],
                  value: _thvalue,
                  items: nameList.map(
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
                    setState(() => _thvalue = value);
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
    super.initState();
    
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }


  void setController(String url) {
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(url);
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);
  }

  Widget AttackVideoList(context, String _thvalue) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection("videos/home village/" + _thvalue).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.documents.length > 0) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return AttackVideoCard(document.data['url']);
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
                      color: Colors.black,
                      fontSize: 14.0,
                      fontFamily: 'Quicksand'),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  bool _isPlayerReady = false;

  Widget AttackVideoCard(String url) {
    setController(url);
    // while(_isPlayerReady==false);
    return 
    Container(
      padding: EdgeInsets.only(bottom: 20),
      child: YoutubePlayerBuilder(
        onExitFullScreen: () {
          // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
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
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                log('Settings Tapped!');
              },
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
