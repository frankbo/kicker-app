import 'package:flutter/material.dart';

class LocationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(context);
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("KickerApp"))),
        body: Text("here comes the detail page"));
  }
}
