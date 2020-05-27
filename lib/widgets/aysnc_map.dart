import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kicker_app/widgets/loading_spinner.dart';
import 'package:kicker_app/widgets/location_map.dart';
import 'package:provider/provider.dart';

class AsyncMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Position>(
      builder: (context, location, _) {
        if (location == null) {
          return LoadingSpinner();
        } else {
          return LocationMap(location);
        }
      },
    );
  }
}
