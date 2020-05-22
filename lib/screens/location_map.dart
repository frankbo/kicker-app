import 'package:flutter/material.dart';

import '../routes.dart';

_toListView(BuildContext context) => () => Navigator.pushReplacementNamed(
    context,
    new Routes().listViewRoute); //TODO create singelton with Routes definintion

class LocationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Center(child: Text("KickerApp")), actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.list),
          onPressed: _toListView(context),
        ),
      ]),
      body: Text("here comes the map"));
}
