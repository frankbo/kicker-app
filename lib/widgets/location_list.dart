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
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
    title: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.asset('assets/images/logo.png',
          height: 80, width: 80, fit: BoxFit.contain),
      Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  location.name,
                  style: TextStyle(fontSize: 20),
                ),
                Text(location.city)
              ],
            )),
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
