import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBaseAttackStrategy extends StatefulWidget {
  @override
  _HomeBaseAttackStrategyState createState() => _HomeBaseAttackStrategyState();
}

class _HomeBaseAttackStrategyState extends State<HomeBaseAttackStrategy>{

  @override
  Widget build(BuildContext context) {
  var title = 'Attack Strategy Videos';
  String _thvalue = "Town Hall 12";
  var nameList = [
    "Town Hall 13",
    "Town Hall 12",
    "Town Hall 11",
    "Town Hall 10",
    "Town Hall 9",
    "Town Hall 8",
    "Town Hall 7",
  ];
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
          body: Text("data"), 
      
    );
  }
}
