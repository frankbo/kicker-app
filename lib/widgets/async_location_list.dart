import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/widgets/loading_spinner.dart';
import 'package:kicker_app/widgets/location_list.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

Future<List<Tuple2<double, Location>>> _filterByClosestLocation(
    Position position, List<Location> locations) {
  final locationsAndDistances = locations.map((l) => Geolocator()
      .distanceBetween(position.latitude, position.longitude, l.loc.latitude,
          l.loc.longitude)
      .then((d) => Tuple2(d, l)));

  return Future.wait(locationsAndDistances)
      .then((List<Tuple2<double, Location>> v) {
    v.sort((a, b) => a.item1.compareTo(b.item1));
    return v;
  }).catchError((e) => print(e));
}

class AsyncLocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<Position, List<Location>>(
      builder: (context, position, locations, _) {
        return (position == null || locations == null)
            ? LoadingSpinner()
            : FutureBuilder(
                future: _filterByClosestLocation(position, locations),
                builder: (context, snapshot) => snapshot.hasData
                    ? LocationList(snapshot.data)
                    : LoadingSpinner());
      },
    );
  }
}
