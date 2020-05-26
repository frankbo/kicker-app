import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kicker_app/widgets/loading_spinner.dart';

import 'location_map.dart';

class AsyncMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Position>(
        future: Geolocator().getCurrentPosition(), // a Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingSpinner();
            default:
              if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else {
                final currentLocation = snapshot.data;
                return LocationMap(currentLocation);
              }
          }
        });
  }
}
