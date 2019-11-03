// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hope_box/main.dart';

void main() {
  testWidgets('Entering a text into text field changes the field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our text field contains nothing at the beginning
    expect(find.text('Hello'), findsNothing);

    // Verify that the text field changes after text is added
    await tester.enterText(find.byType(TextField), 'Hello');
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('Entering special characters and combinations of different character types works as intended', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.enterText(find.byType(TextField), '#3LL0 W0®LD!?!');
    expect(find.text('#3LL0 W0®LD!?!'), findsOneWidget);
  });

  testWidgets('Tapping the "Done" icon resets the text field', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.enterText(find.byType(TextField), 'Some text');
    expect(find.text('Some text'), findsOneWidget);

    // Verify that after tapping the "Done" icon, it resets the textbox
    await tester.tap(find.byIcon(Icons.done));
    // Shows up with pop-up, so tap again on screen to remove it
    await tester.tap(find.byIcon(Icons.done));
    expect(find.text('Some text'), findsNothing);
  });
}
