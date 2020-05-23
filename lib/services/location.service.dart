import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kicker_app/models/location.dart';

Stream<Location> getLocationByDocumentId(String collection, String documentId) =>
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


Stream<List<Location>> getLocations(String collection) {
  // TODO is this stream transformation correct?
  return Firestore.instance
      .collection(collection)
      .snapshots()
      .map((qs) => qs.documents.map((doc) {
            try {
              return Location.fromSnapshot(doc);
            } catch (e) {
              print(e);
              return null;
            }
          }));
}
