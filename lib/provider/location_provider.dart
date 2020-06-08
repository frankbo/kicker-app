import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kicker_app/models/location.dart';

class LocationProvider {
  static Future<Position> getCurrentPosition() =>
      Geolocator().getCurrentPosition();

  static Stream<Location> getLocationByDocumentId(
          String collection, String documentId) =>
      Firestore.instance
          .collection(collection)
          .document(documentId)
          .get()
          .then((snapshot) {
        try {
          return Location.fromSnapshot(snapshot);
        } catch (e) {
          print(e);
          return null;
        }
      }).asStream();

  static Stream<List<Location>> getLocations(String collection) =>
      Firestore.instance // TODO pass snapshots in the function
          .collection(collection)
          .snapshots()
          .map((qs) => qs.documents.map((doc) {
                try {
                  return Location.fromSnapshot(doc);
                } catch (e) {
                  print(e);
                  return null;
                }
              }).toList());
}
