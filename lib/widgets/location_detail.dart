import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kicker_app/models/location.dart';
import 'package:url_launcher/url_launcher.dart';

const googleMapsUrl = 'https://www.google.com/maps/';

Future<Null> Function() _launchURL(Location location) => () async {
      String googleUrl = googleMapsUrl +
          'search/?api=1&query=${location.loc.latitude},${location.loc.longitude}';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not launch $googleUrl';
      }
    };

class LocationDetail extends StatelessWidget {
  final Location location;
  LocationDetail(this.location);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: _launchURL(location),
        child: Text('Bring me to the location'),
      ),
    );
  }
}
