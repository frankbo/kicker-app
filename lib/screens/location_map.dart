import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kicker_app/widgets/loading_spinner.dart';

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

  void _toListView(BuildContext context) {
    final routes = new Routes();
    Navigator.pushReplacementNamed(context,
        routes.listViewRoute); //TODO create singelton with Routes definintion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("KickerApp")), actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            _toListView(context);
          },
        ),
      ]),
      body: StreamBuilder(
        stream: Firestore.instance.collection("kicker-locations").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingSpinner();
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]));
          }
        },
      ),
    );
  }
}
