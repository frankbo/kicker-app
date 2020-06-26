import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/static/keys.dart';
import 'package:kicker_app/static/kicker-colors.dart';
import 'package:url_launcher/url_launcher.dart';

const googleMapsUrl = 'https://www.google.com/maps/';

_launchMapsURL(Location location) async {
  String googleUrl = googleMapsUrl +
      'search/?api=1&query=${location.loc.latitude},${location.loc.longitude}';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not launch $googleUrl';
  }
}

_launchHomepageURL(String homepage) async {
  if (await canLaunch(homepage)) {
    await launch(homepage);
  } else {
    throw 'Could not launch $homepage';
  }
}

Widget _heroIcon() {
  return Stack(children: [
    ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.grey,
          BlendMode.saturation,
        ),
        child: Opacity(
          opacity: 0.6,
          child:
              Image.asset('assets/images/kicker-table.png', fit: BoxFit.fill),
        )),
    Positioned.fill(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.camera_alt,
          size: 40,
        ),
        Text(
          "Kein Foto",
          textAlign: TextAlign.center,
        )
      ],
    ))
  ]);
}

Widget _overview(Location location) {
  return Container(
    color: KickerColors.main,
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(location.name), Text("xxx km")],
    ),
  );
}

Widget _descriptionArea(Location location) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
              "Some Description ${location.name} about the location: price, table, tableStatus"),
        )
      ],
    ),
  );
}

Widget _staticMap(Location location) {
  final mapStyle = "osm-carto";
  final width = "600";
  final height = "200";
  final apiBaseUrl = "https://maps.geoapify.com";
  return GestureDetector(
    onTap: () {
      _launchMapsURL(location);
    },
    child: Image.network(
      "$apiBaseUrl/v1/staticmap?style=$mapStyle&width=$width&height=$height&center=lonlat:${location.loc.longitude},${location.loc.latitude}&zoom=14&marker=lonlat:${location.loc.longitude},${location.loc.latitude};color:%23ff0000;size:medium&apiKey=${Keys.geoapifyKey}",
    ),
  );
}

Widget _phoneArea(String phone) => Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.phone),
          ),
          Text(phone),
        ],
      ),
    );

Widget _locationArea(Location location) => GestureDetector(
      onTap: () {
        _launchMapsURL(location);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.directions),
            ),
            Text("Bring mich zur Location."),
          ],
        ),
      ),
    );

Widget _homepageArea(String homepage) => GestureDetector(
      onTap: () {
        _launchHomepageURL(homepage);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.link),
            ),
            Text("Schau dir die Webseite an."),
          ],
        ),
      ),
    );

Widget _getInTouchArea(Location location) {
  final emptyElement = Container(width: 0, height: 0);
  final phoneArea =
      (location.phone != null) ? _phoneArea(location.phone) : emptyElement;
  final websiteArea = (location.homepage != null)
      ? _homepageArea(location.homepage)
      : emptyElement;

  return Column(
    children: [
      phoneArea,
      _locationArea(location),
      websiteArea,
    ],
  );
}

Widget _updateInfo() {
  return Center(
      child: Row(
    children: [
      Icon(Icons.edit),
      Text('Falsche Informationen?'),
    ],
  ));
}

class LocationDetail extends StatelessWidget {
  final Location location;
  LocationDetail(this.location);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _heroIcon(),
        _overview(this.location),
        _descriptionArea(this.location),
        _staticMap(this.location),
        _getInTouchArea(this.location),
        _updateInfo()
      ],
    );
  }
}
