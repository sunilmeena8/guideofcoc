import 'package:flutter/material.dart';
class BuilderBaseBaseLayouts extends StatefulWidget {
  @override
  _BuilderBaseBaseLayoutsState createState() => _BuilderBaseBaseLayoutsState();
}

class _BuilderBaseBaseLayoutsState extends State<BuilderBaseBaseLayouts> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
    Tab(text: "Bottom"),
    Tab(text: "Up",),
  ];
  
  @override
  Widget build(BuildContext context) {
    final title = 'Base Layouts';
    

    return
    DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Text("WAR")),
                Tab(icon: Text("TROPHY")),
                Tab(icon: Text("HYBRID")),
                Tab(icon: Text("FARMING")),
              ],
            ),
            title: Text(title),
          ),
          body: TabBarView(
            children: <Widget>[
              baseList("WAR"),
              baseList("TROPHY"),
              baseList("HYBRID"),
              baseList("FARMING"),
            ]
          ),
        
      ),
    );
    
  }
  Container baseList(String type) {
    return Container(
      child: Text(type),
    );
    
  }
}