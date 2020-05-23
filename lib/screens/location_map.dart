import 'package:flutter/material.dart';
import 'package:kicker_app/screens/location_list.dart';

Future<Object> Function() _toListView(BuildContext context) =>
    () => Navigator.pushReplacementNamed(context, LocationListPage.route);

class LocationMapPage extends StatelessWidget {
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
