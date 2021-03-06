import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kicker_app/lib/location_calculation.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/static/keys.dart';
import 'package:kicker_app/static/kicker-colors.dart';
import 'package:url_launcher/url_launcher.dart';

const googleMapsUrl = 'https://www.google.com/maps/';

_launch(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchMapsURL(Location location) {
  String googleUrl = googleMapsUrl +
      'search/?api=1&query=${location.loc.latitude},${location.loc.longitude}';
  _launch(googleUrl);
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

Widget _overview(Location location, double distanceAway) {
  final distanceInKm = roundDouble(meterToKilometers(distanceAway), 2);
  return Container(
    color: KickerColors.main,
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          location.name,
          style: TextStyle(color: KickerColors.textColorLight),
        ),
        Text(
          "$distanceInKm km",
          style: TextStyle(color: KickerColors.textColorLight),
        )
      ],
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
  final height = "400";
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

Widget _phoneArea(String phone) => GestureDetector(
      onTap: () {
        _launch("tel://$phone");
      },
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 4, color: Colors.grey)),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.phone),
            ),
            Text(phone),
          ],
        ),
      ),
    );

Widget _locationArea(Location location) => GestureDetector(
      onTap: () {
        _launchMapsURL(location);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 4, color: KickerColors.lightGrey)),
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
        _launch(homepage);
      },
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 4, color: Colors.grey)),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.link),
            ),
            Text("Geh zur Homepage."),
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
  return Container(
    margin: const EdgeInsets.only(top: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlineButton(
          onPressed: () {
            _launch("mailto:support@not-available.com");
          },
          borderSide: BorderSide(width: 1.0, color: KickerColors.main),
          child: Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Icon(Icons.edit),
                ),
                Text('Falsche Informationen?'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class LocationDetail extends StatelessWidget {
  final Location location;
  final double distanceAway;
  LocationDetail(this.location, this.distanceAway);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _heroIcon(),
        _overview(this.location, distanceAway),
        _descriptionArea(this.location),
        _staticMap(this.location),
        _getInTouchArea(this.location),
        _updateInfo()
      ],
    );
  }
}
