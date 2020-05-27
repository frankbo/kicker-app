import 'package:flutter/material.dart';
import 'package:kicker_app/screens/location_list.dart';
import 'package:kicker_app/widgets/aysnc_map.dart';

Future<Object> Function() _toListView(BuildContext context) =>
    () => Navigator.pushReplacementNamed(context, LocationListPage.route);

class LocationMapPage extends StatelessWidget {
  static final route = '/';

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Center(child: Text("KickerApp")),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _toListView(context),
          ),
        ],
        centerTitle: true,
      ),
      body: AsyncMap());
}
