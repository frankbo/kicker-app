import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class LocationMap extends StatelessWidget {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        title: Row(children: [
          Expanded(
            child: Text(document['num'].toString()),
          ),
        ]),
        onTap: () {
          document.reference.updateData({'num': document['num'] + 1});
        });
  }

  _toListView(BuildContext context) {
    return () => Navigator.pushReplacementNamed(
        context,
        new Routes()
            .listViewRoute); //TODO create singelton with Routes definintion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Center(child: Text("KickerApp")), actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _toListView(context),
          ),
        ]),
        body: Text("here comes the map"));
  }
}
