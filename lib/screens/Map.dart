import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Kicker App")),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("kicker-locations").snapshots(),
        builder: (context, snapshot) {
          print(snapshot.data.documents);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
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
