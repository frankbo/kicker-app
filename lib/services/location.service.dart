import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kicker_app/models/location.dart';

Stream<Location> getLocationByDocumentId(String collection, String documentId) {
  return Firestore.instance
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
}
