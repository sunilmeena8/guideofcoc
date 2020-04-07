import 'package:flutter/material.dart'; 

class HomeBaseSpells extends StatelessWidget {
  var spells = [
    'images/home base/spells/healing.jpg',
    'images/home base/spells/lightning.jpg',
    'images/home base/spells/rage.jpg',
    'images/home base/spells/jump.jpg',
    'images/home base/spells/clone.jpg',
    'images/home base/spells/freeze.jpg',
    'images/home base/spells/earthquake.jpg',
    'images/home base/spells/poison.jpg',
    'images/home base/spells/haste.jpg',
    'images/home base/spells/skeleton.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final title = 'Spells';
    List<String> spellName = ['Healing','Lightning','Rage','Jump','Clone','Earthquake','Poison','Haste','Skeleton','Bat'];

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
                          spellName.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeBaseSpellsView(spellName[index])),
                                  );
                                },
                                child: Container(
                                    // margin: EdgeInsets.all(1.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Image(image: AssetImage(spells[index])),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: 300,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: Center(
                                                child: Text(
                                                    spellName[index],
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

class HomeBaseSpellsView extends StatelessWidget{
  String spellname;
  final children = <Widget>[];
  HomeBaseSpellsView(String spellname){
    this.spellname = spellname;
  }

  @override
  Widget build(BuildContext context){
    final title = spellname;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(spellname)
        )
      );
  }
}

