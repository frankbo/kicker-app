import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/screens/location_details.dart';

Future<Object> Function() _navigateToDetails(
        BuildContext context, Location location) =>
    () => Navigator.pushNamed(context, LocationDetailsPage.route,
        arguments: location);

Set<Marker> _locationsToMarkers(
    BuildContext context, List<Location> locations) => locations.map((location) {
    final lat = location.loc.latitude;
    final long = location.loc.longitude;
    return Marker(
      markerId: MarkerId(lat.toString() + long.toString()),
      position: LatLng(lat, long),
      infoWindow: InfoWindow(
        title: location.name,
        snippet: location.city,
        onTap: _navigateToDetails(context, location),
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
  }).toSet();


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
  final List<Location> locations;
  const LocationMap(this.position, this.locations);

  @override
  LocationMapState createState() => LocationMapState();
}

class LocationMapState extends State<LocationMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final position = widget.position;
    final _markers = _locationsToMarkers(context, widget.locations);
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
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
