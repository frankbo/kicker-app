import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kicker_app/screens/location_map.dart';

void main() {
  var materialApp = MaterialApp(
    home: Scaffold(
      body: LocationMapPage(),
    ),
  );

  testWidgets('Appbar should have one IconButton', (WidgetTester tester) async {
    await tester.pumpWidget(materialApp);
    final iconButton = find.byType(IconButton);
    expect(iconButton, findsNWidgets(1));
  });

  testWidgets("Appbar should have one icon to navigate to the list view",
      (WidgetTester tester) async {
    await tester.pumpWidget(materialApp);
    await tester.press(find.byType(IconButton));
    // TODO no clue yet how to test that
  });
}
