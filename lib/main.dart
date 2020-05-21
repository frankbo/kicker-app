import 'package:flutter/material.dart';
import 'package:kicker_app/routes.dart';
import 'package:kicker_app/screens/Map.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var routes = new Routes();
    return MaterialApp(title: 'Flutter Demo', initialRoute: '/', routes: {
      '/': (context) => Map(),
      routes.listViewRoute: (context) => Map(),
    });
  }
}
