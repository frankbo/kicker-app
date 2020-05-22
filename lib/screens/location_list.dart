import 'package:flutter/material.dart';
import 'package:kicker_app/widgets/locations.dart';

import '../routes.dart';

Future<Object> Function() _toMapView(BuildContext context) =>
    () => Navigator.pushReplacementNamed(context,
        new Routes().root); //TODO create singelton with Routes definintion

class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Center(child: Text("KickerApp")), actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.map),
            onPressed: _toMapView(context),
          ),
        ]),
        body: Locations());
  }
}
