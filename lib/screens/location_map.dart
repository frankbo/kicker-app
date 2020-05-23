import 'package:flutter/material.dart';
import 'package:kicker_app/screens/location_list.dart';

_toListView(BuildContext context) =>
    () => Navigator.pushReplacementNamed(context, LocationList.route);

class LocationMap extends StatelessWidget {
  static final route = '/';

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
