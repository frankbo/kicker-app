import 'package:cloud_firestore/cloud_firestore.dart';

class LastVisit {
  String month;
  String year;

  LastVisit.fromMap(Map<dynamic, dynamic> data)
      : month = data["month"],
        year = data["year"];
}

class Location {
  String documentID;
  String city;
  LastVisit lastVisit;
  String name;
  String plz;
  String street;
  GeoPoint loc;

  Location.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        city = snapshot['city'],
        lastVisit = LastVisit.fromMap(snapshot['lastVisit']),
        name = snapshot['name'],
        plz = snapshot['plz'],
        street = snapshot['street'],
        loc = snapshot['loc'];
}
