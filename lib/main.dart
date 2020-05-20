import 'package:flutter/material.dart';
import 'package:kicker_app/screens/Map.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', initialRoute: '/', routes: {
      '/': (context) => Map(),
      '/list-search': (context) => Map(),
    });
  }
}
