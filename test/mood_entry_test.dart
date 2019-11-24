import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/mood_entry.dart';

void main() {
    testWidgets('When Sentiment Analysis is disabled, user can set a mood entry', (WidgetTester tester) async {
    // Build our MoodEntry Widget
    await tester.pumpWidget(MoodEnter());

    // Tap the dissatisfied icon
    await tester.tap(find.byIcon(Icons.sentiment_dissatisfied));
    await tester.pump();

    // Verify that an alert dialog is not triggered
    expect(find.byKey(new Key('alert_dialog')), findsNothing);
  });

  testWidgets('When sentiment is analysis is enabled, a pop up is displayed when user tries to set a mood entry', (WidgetTester tester) async {
    // Build our Mood Entry Widget
    await tester.pumpWidget(MoodEnter());

    // Tap the sentiment analysis switch so sentiment analysis is enabled
    await tester.tap(find.byKey(new Key('sentiment_analysis_switch')));
    await tester.pumpAndSettle();
    // If a user tries to manually select a mood, it should trigger an alert dialog
    await tester.tap(find.byIcon(Icons.sentiment_dissatisfied));
    await tester.pump();

    // Verify that an alert dialog is shown
    expect(find.byKey(new Key('alert_dialog')), findsOneWidget);
  });
}
