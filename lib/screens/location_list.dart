import 'package:flutter/material.dart';

import '../routes.dart';

class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Center(child: Text("KickerApp")), actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              _toMapView(context);
            },
          ),
        ]),
        body: Text("Here comes the list view"));
  }

  void _toMapView(BuildContext context) {
    var routes = new Routes();
    Navigator.pushReplacementNamed(context,
        routes.mapViewRoute); //TODO create singelton with Routes definintion
  }
}
