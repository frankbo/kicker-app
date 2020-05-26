import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> _jumpToCurrentPosition(Completer<GoogleMapController> c) async {
  final Position currentLocation = await Geolocator().getCurrentPosition();
  final CameraPosition location = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 14);
  final GoogleMapController controller = await c.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(location));
}

class LocationMap extends StatefulWidget {
  final Position position;
  const LocationMap(this.position);

  @override
  LocationMapState createState() => LocationMapState();
}

class LocationMapState extends State<LocationMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final position = widget.position;
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14),
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
