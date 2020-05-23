import 'package:flutter/material.dart';
import 'package:kicker_app/models/location.dart';

class LocationDetails extends StatelessWidget {
  static final String route = "/location-details";

  final Location arguments;
  LocationDetails(this.arguments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("KickerApp"))),
        body: Text("here comes the detail page"));
  }
}
