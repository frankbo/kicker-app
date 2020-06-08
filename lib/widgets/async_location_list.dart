import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/widgets/loading_spinner.dart';
import 'package:kicker_app/widgets/location_list.dart';
import 'package:provider/provider.dart';

class AsyncLocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<Position, List<Location>>(
      builder: (context, position, locations, _) {
        return (position == null || locations == null)
            ? LoadingSpinner()
            : LocationList(locations);
      },
    );
  }
}
