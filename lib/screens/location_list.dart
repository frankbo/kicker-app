import 'package:flutter/material.dart';
import 'package:kicker_app/screens/location_map.dart';
import 'package:kicker_app/widgets/location_list.dart';

Future<Object> Function() _toMapView(BuildContext context) =>
    () => Navigator.pushReplacementNamed(context, LocationMapPage.route);

class LocationListPage extends StatelessWidget {
  static final String route = "/list-search";

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
        body: LocationList());
  }
}
