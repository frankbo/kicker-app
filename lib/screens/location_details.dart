import 'package:flutter/material.dart';
import 'package:kicker_app/models/location.dart';

class LocationDetailsPage extends StatelessWidget {
  static final String route = "/location-details";

  final Location arguments;
  LocationDetailsPage(this.arguments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("KickerApp"))),
        body: Text("here comes the detail page"));
  }
}
