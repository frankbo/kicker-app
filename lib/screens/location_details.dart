import 'package:flutter/material.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/widgets/async_location_detail.dart';

class LocationDetailsPage extends StatelessWidget {
  static final String route = "/location-details";

  final Location arguments;
  const LocationDetailsPage(this.arguments);

  @override
  Widget build(BuildContext context) {
    print(this.arguments);
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("KickerApp")),
          centerTitle: true,
        ),
        body: AsyncLocationDetail(this.arguments));
  }
}
