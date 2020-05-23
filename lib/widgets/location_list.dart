import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kicker_app/models/location.dart';
import 'package:kicker_app/screens/location_details.dart';

import 'loading_spinner.dart';

Future<Object> Function() _navigateToDetails(
        BuildContext context, Location location) =>
    () => Navigator.pushNamed(context, LocationDetailsPage.route,
        arguments: location);

ListTile _buildLocationItem(BuildContext context, Location location) {
  final test = location.city +
      " " +
      location.lastVisit?.year +
      " " +
      location.name +
      " " +
      location.plz +
      " " +
      location.loc.longitude.toString() +
      " " +
      location.loc.latitude.toString();
  return ListTile(
    title: Row(children: [
      Image.asset('assets/images/logo.png', height: 80, width: 80),
      Expanded(
        child: Text(test),
      ),
    ]),
    onTap: _navigateToDetails(context, location),
  );
}

class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("kicker-locations").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingSpinner();
        } else {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => _buildLocationItem(context,
                  Location.fromSnapshot(snapshot.data.documents[index])));
        }
      },
    );
  }
}
