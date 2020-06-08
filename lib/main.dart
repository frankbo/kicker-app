import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kicker_app/provider/location_provider.dart';
import 'package:kicker_app/screens/location_details.dart';
import 'package:kicker_app/screens/location_list.dart';
import 'package:kicker_app/screens/location_map.dart';
import 'package:provider/provider.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          FutureProvider(create: (_) => LocationProvider.getCurrentPosition()),
          StreamProvider(
            create: (_) => LocationProvider.getLocations("kicker-locations"),
          )
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
