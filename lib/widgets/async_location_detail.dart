import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/widgets/loading_spinner.dart';
import 'package:kicker_app/widgets/location_detail.dart';
import 'package:provider/provider.dart';

class AsyncLocationDetail extends StatelessWidget {
  final Location l;
  AsyncLocationDetail(this.l);

  @override
  Widget build(BuildContext context) {
    return Consumer<Position>(
      builder: (context, position, _) {
        return (position == null)
            ? LoadingSpinner()
            : FutureBuilder(
                future: Geolocator().distanceBetween(
                    position.latitude,
                    position.longitude,
                    this.l.loc.latitude,
                    this.l.loc.longitude),
                builder: (context, snapshot) => snapshot.hasData
                    ? LocationDetail(this.l, snapshot.data)
                    : LoadingSpinner());
      },
    );
  }
}
