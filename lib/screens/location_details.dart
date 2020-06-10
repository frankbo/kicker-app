import 'package:flutter/material.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/widgets/location_detail.dart';

class LocationDetailsPage extends StatelessWidget {
  static final String route = "/location-details";

  final Location location;
  LocationDetailsPage(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("KickerApp")),
          centerTitle: true,
        ),
        body: LocationDetail(this.location));
  }
}
