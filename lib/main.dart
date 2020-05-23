import 'package:flutter/material.dart';
import 'package:kicker_app/screens/location_details.dart';
import 'package:kicker_app/screens/location_list.dart';
import 'package:kicker_app/screens/location_map.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
          title: 'Flutter Demo',
          initialRoute: LocationMap.route,
          routes: {
            LocationMap.route: (context) => LocationMap(),
            LocationList.route: (context) => LocationList(),
            LocationDetails.route: (context) =>
                LocationDetails(ModalRoute.of(context).settings.arguments)
          });
}
