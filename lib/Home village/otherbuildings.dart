import 'package:flutter/material.dart';

class HomeBaseOtherBuildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Yoes');
    final title = 'Other buildings';
    List<String> buildingName = [
      'Clan Castle',
      'Laboratory',
      'Barracks',
      'Dark Barracks',
      'Army camp',
      'Spell factory',
      'Dark spell factory',
      'Gold Storage',
      'Elixir Storage',
      'Dark Elixir storage',
      'Gold Mine',
      'Elixir collector',
      'Dark Elixir drill',
      "Builder's Hut",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: new List.generate(
              buildingName.length,
              (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeBaseOtherBuildingView(buildingName[index])),
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
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: Text(buildingName[index],
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
      ),
    );
  }
}

class HomeBaseOtherBuildingView extends StatelessWidget {
  String name;
  final children = <Widget>[];
  HomeBaseOtherBuildingView(String name) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    final title = name;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: Text(name)));
  }
}
