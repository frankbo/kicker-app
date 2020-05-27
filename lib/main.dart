import 'package:flutter/material.dart';
import 'package:kicker_app/provider/location_provider.dart';
import 'package:kicker_app/screens/location_details.dart';
import 'package:kicker_app/screens/location_list.dart';
import 'package:kicker_app/screens/location_map.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          FutureProvider(create: (_) => LocationProvider.getCurrentLocation()),
        ],
        child: MaterialApp(
            title: 'KickerApp',
            initialRoute: LocationMapPage.route,
            routes: {
              LocationMapPage.route: (context) => LocationMapPage(),
              LocationListPage.route: (context) => LocationListPage(),
              LocationDetailsPage.route: (context) =>
                  LocationDetailsPage(ModalRoute.of(context).settings.arguments)
            }),
      );
}
