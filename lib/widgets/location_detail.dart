import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/static/kicker-colors.dart';
import 'package:url_launcher/url_launcher.dart';

const googleMapsUrl = 'https://www.google.com/maps/';

_launchURL(Location location) async {
  String googleUrl = googleMapsUrl +
      'search/?api=1&query=${location.loc.latitude},${location.loc.longitude}';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not launch $googleUrl';
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

Widget _overView(Location location) {
  return Container(
      color: KickerColors.main,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(location.name), Text("xxx km")],
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
        _overView(this.location),
        Center(
          child: RaisedButton(
            onPressed: () {
              _launchURL(location);
            },
            child: Text('Bring me to the location'),
          ),
        ),
      ],
    );
  }
}
