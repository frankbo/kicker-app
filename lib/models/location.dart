import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class LastVisit {
  final String month;
  final String year;

  LastVisit.fromMap(Map<dynamic, dynamic> data)
      : month = data["month"],
        year = data["year"];
}

@immutable
class Location {
  final String documentID;
  final String city;
  final LastVisit lastVisit;
  final String name;
  final String plz;
  final String street;
  final GeoPoint loc;

  Location.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        city = snapshot['city'],
        lastVisit = LastVisit.fromMap(snapshot['lastVisit']),
        name = snapshot['name'],
        plz = snapshot['plz'],
        street = snapshot['street'],
        loc = snapshot['loc'];
}
