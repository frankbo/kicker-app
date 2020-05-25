import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kicker_app/widgets/loading_spinner.dart';

Future<void> _jumpToCurrentPosition(Completer<GoogleMapController> c) async {
  final Position currentLocation = await Geolocator().getCurrentPosition();
  final CameraPosition location = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 14);
  final GoogleMapController controller = await c.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(location));
}

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();

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
              return new Scaffold(
                body: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLocation.latitude, currentLocation.longitude),
                      zoom: 14),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.my_location),
                  onPressed: () {
                    _jumpToCurrentPosition(_controller);
                  },
                ),
              );
            }
        }
      },
    );
  }
}
